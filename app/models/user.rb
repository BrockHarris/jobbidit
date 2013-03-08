class User < ActiveRecord::Base
  has_many :authentications, :dependent => :destroy
  has_many :jobs
  has_many :bids
  has_many :comments
  has_attached_file :photo,
                    :styles => {
                    :thumb => "25x25#",
                    :small=> "50x50#",
                    :medium=> "100x100#",
                    :large  => "200x200#" },
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path => "/:style/:id/:filename" 

  validates :username, :length=>{:minimum => 3}, :uniqueness=>true, :format=>{ :with => /^[-\w\._@]+$/i, :message => "should only contain letters, numbers, or .-_@"}
  validates :email, :uniqueness=>true, :format=>{:with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i, :message => "we need a valid email address!"}
  validates :password, :length=>{:minimum => 4}, :on => :create, :unless=>Proc.new{|u| u.service_mode?}                
  validates_confirmation_of :password

  attr_accessible :email, :facebook_id, :token, :username, :password, :mode, :password_confirmation, :firstname, :lastname, 
                  :address, :state, :zip, :phone, :role, :photo, :activation_code, :activated_at, :admin
  attr_accessor :password, :mode

  before_save :prepare_password

  default_scope where("users.deleted_at IS NULL")
  scope :created_order, order("users.created_at DESC")

  def destroy
   update_attribute(:deleted_at, Time.now.utc)
   run_callbacks(:destroy) 
  end 

  def self.authenticate(login, pass)
    user = self.where(["username=? OR email=?", login, login]).first
    return user if user && user.matching_password?(pass) && user.active?
  end

  def service_mode?
    mode=="service"
  end

  def pending?
    state == 'pending'
  end

  def active?
    # the existence of an activation code means they have not activated yet
    state == 'active' && activation_code.nil?
  end

  def inactive?
    state == 'inactive'
  end

  def activate!
    self.state = 'active'
    self.activated_at = Time.now.utc
    self.activation_code = nil
    save(:validate=>false)
  end

  def inactivate!
    self.state = 'inactive'
    self.activated_at = nil
    self.activation_code = nil
    save(:validate=>false)
  end 

  def new_code
    SecureRandom.hex(6)
  end

  def make_reset_code
    self.reset_code = new_code
    self.reset_code_at = Time.now.utc
  end

  def matching_password?(pass)
    self.password_hash == encrypt_password(pass)
  end

  #generates an activation code and sets state to pending
  def register!
    self.state = "pending"
    self.activation_code = new_code
    self.activated_at = nil    
    save(:validate=>false)
  end

  def send_activation_email!
    # Preconditions checked by UserMailer.deliver_activation.
    transaction do
      UserMailer.activation(self).deliver
      self.activation_email_sent_at = Time.now
      self.save!
    end
  end

  def send_reset_password_email!
    if self.active? || self.pending?
      transaction do
        make_reset_code
        save!
        UserMailer.forgot(self).deliver
      end
    end
  end

  def send_welcome_email!
    if self.active? || self.pending?
      transaction do
        make_reset_code
        save!
        UserMailer.welcome(self).deliver
      end
    end
  end
  
  private
  
  def prepare_password
    unless password.blank?
      self.password_salt = Digest::SHA1.hexdigest([Time.now, rand].join)
      self.password_hash = encrypt_password(password)
    end
  end
  
  def encrypt_password(pass)
    Digest::SHA1.hexdigest([pass, password_salt].join)
  end
end
