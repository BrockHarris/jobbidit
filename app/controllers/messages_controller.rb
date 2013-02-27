class MessagesController < ApplicationController
	def create
    @message = Message.new(params[:message])
    if @message.valid?
      ContactMailer.new_message(@message).deliver
      redirect_to root_path
      flash[:notice] = "Your message has been sent!"
    else
      flash[:notice] = "Please fill out all of the fields."
      redirect_to (:back)
    end
  end
end
