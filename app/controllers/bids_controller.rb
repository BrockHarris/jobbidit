class BidsController < ApplicationController
  before_filter :login_required

  def create
		@bid = Bid.new(params[:bid])
    @bidder = current_user
    if @bid.save
      flash[:notice] = "Your bid has been placed!" 
      redirect_to(:back)
    else 
      flash[:notice] = "Invalid bid amount." 
      redirect_to(:back)
    end
	end

	def destroy
    @bid = Bid.find(params[:id])
    Bid.find(@bid).destroy
    flash[:notice] = "Your bid has been removed." 
    redirect_to(:back)
	end
end
