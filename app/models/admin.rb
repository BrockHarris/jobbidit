class Admin < ActiveRecord::Base

	attr_accessible :username, :email, :password, :password_confirmation
  attr_accessor :password

	validates :username, :length=>{:minimum => 3}, :uniqueness=>true, :format=>{ :with => /^[-\w\._@]+$/i, :message => "should only contain letters, numbers, or .-_@"}
	validates :email, :uniqueness=>true, :format=>{:with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i, :message => "we need a valid email address."}
	validates :password, :length=>{:minimum => 4}, :on => :create 
  validates_confirmation_of :password

  before_save :prepare_password

  def self.authenticate(login, pass)
    admin = self.where(["username=? OR email=?", login, login]).first
    return admin if admin && admin.matching_password?(pass) 
  end

  def matching_password?(pass)
    self.password_hash == encrypt_password(pass)
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
