ActionMailer::Base.smtp_settings = {  
  :address              => "smtp.sendgrid.net",  
  :port                 => 587,  
  :domain               => "jobbidit.heroku.com",  
  :user_name            => "btharris781",  
  :password             => "jobbidit",  
  :authentication       => "plain",  
  :enable_starttls_auto => true  
}  