class Authentication < ActiveRecord::Base
	attr_accessible :user_id, :provider, :token, :uid, :activation_code, :activated_at
  belongs_to :user

  def pending?
    state == 'pending'
  end

  def send_activation_email!
    # Preconditions checked by UserMailer.deliver_activation.
    transaction do
      UserMailer.activation(self).deliver
      self.activation_email_sent_at = Time.now
      self.save!
    end
  end
end
