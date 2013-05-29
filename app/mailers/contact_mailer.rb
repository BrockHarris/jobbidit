class ContactMailer < ActionMailer::Base
  default :from => "support@scoutjack.herokuapp.com"
  default :to => "stsikder@gmail.com"

  def new_message(message)
    @message = message
    mail(:subject => "ScoutJack Inquiry: #{message.subject}")
  end
end
