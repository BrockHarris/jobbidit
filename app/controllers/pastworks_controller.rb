class PastworksController < ApplicationController
	before_filter :login_required

	def create
		@pastwork = Pastwork.new(params[:pastwork])
		if @pastwork.save
      flash[:notice] = "Success!"
      redirect_to (:back)
    else
      flash[:error] = "Please fill out the entire form."
      redirect_to (:back)
    end
	end

	def update
		@pastwork = Pastwork.find(params[:id])
		if @pastwork.update_attributes(params[:pastwork])
      flash[:notice] = "Success!"
      redirect_to (:back)
    else
    	flash[:error] = "Please fill out the entire form."
    end
	end

	def destroy
		@pastwork = Pastwork.find(params[:id])
    Pastwork.find(@pastwork).destroy
    flash[:success] = "Your post has been deleted."
    redirect_to (:back)
  end
end
