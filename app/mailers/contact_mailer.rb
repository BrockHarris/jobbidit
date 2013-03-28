class ContactMailer < ActionMailer::Base
  default :from => "support@homefixt.herokuapp.com"
  default :to => "stsikder@gmail.com"

  def new_message(message)
    @message = message
    mail(:subject => "JobBidit Inquiry: #{message.subject}")
  end
end
