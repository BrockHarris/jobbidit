class UserMailer < ActionMailer::Base
  default from: "support@scoutjack.herokuapp.com"

  def activation(user)
    @url  = activate_url(:host => SITE_URL_HOST, :id => user.id, :activation_code => user.activation_code)
    @user = user
    mail(
        :to => ["#{user.email}"],
        :subject => "ScoutJack: Please activate your new account.")
  end

  def welcome(user)
    if user.pending? || user.active?
      @user = user
      @url  = reset_url(:id => user.id, :reset_code => user.reset_code, :host => SITE_URL_HOST)
      mail(
        :to => ["#{user.email}"],
        :subject => "Welcome to ScoutJack!")
    end
  end

  # Sets up an email that gives the user instructions on how to reset the
  # password and provides a link to allow the user to reset the password.  
  def forgot(user)
    if user.pending? || user.active?
      @user = user
      @url        = reset_url(:id => user.id, :reset_code => user.reset_code, :host => SITE_URL_HOST)
      mail( 
          :to => ["#{user.email}"],
          :subject => "ScoutJack: Reset your password.")
    end
  end
end
