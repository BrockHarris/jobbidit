class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def activation(user)
    @url  = activate_url(:host => SITE_URL_HOST, :id => user.id, :activation_code => user.activation_code)
    @user = user
    mail(
        :to => ["#{user.email}"],
        :subject => "JobBidIt: Please activate your new account.")
  end

  # Sets up an email that gives the user instructions on how to reset the
  # password and provides a link to allow the user to reset the password.  
  def forgot(user)
    if user.pending? || user.active?
      @user = user
      @url        = reset_url(:id => user.id, :reset_code => user.reset_code, :host => SITE_URL_HOST)
      mail( 
          :to => ["#{user.email}"],
          :subject => "JobBidit: Reset your password.")
    end
  end
end
