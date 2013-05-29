ActionMailer::Base.smtp_settings = {  
  :address              => "smtp.sendgrid.net",  
  :port                 => 587,  
  :domain               => "scoutjack.herokuapp.com",  
  :user_name            => "btharris781",  
  :password             => "password1",  
  :authentication       => "plain",  
  :enable_starttls_auto => true  
}  