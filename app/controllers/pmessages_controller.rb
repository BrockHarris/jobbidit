class PmessagesController < ApplicationController
	before_filter :login_required

	def index
		@messages = Pmessage.order.find_all_by_receiver_id(current_user.id)
	end

  def create
		@pmessage = Pmessage.new(params[:pmessage])
		if @pmessage.save
      flash[:success] = "Your message has been sent!"
      redirect_to (:back)
    else
      flash[:error] = "Please fill all of the fields."
      redirect_to (:back)
    end
	end

	def show 
	end

	def update
		@pmessage = Pmessage.find(params[:id])
		if @pmessage.update_attributes(params[:pmessage])
      redirect_to (:back)
    end
	end

	def destroy
		@pmessage = Pmessage.find(params[:id])
    Pmessage.find(@pmessage).destroy
    flash[:success] = "Message deleted."
    redirect_to (:back)
  end
end
