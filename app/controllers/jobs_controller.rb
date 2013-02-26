class JobsController < ApplicationController
	before_filter :login_required

	def main
		@user = current_user
		@job = Job.new

		@jobs = Job.all
	end

  def create
		@job = Job.new(params[:job])
		if @job.save
      flash[:notice] = "Your job has been posted!"
      redirect_to @job
    else
      flash[:error] = "Please fill out the entire job form."
      redirect_to (:back)
    end
	end

	def show 
		@job = Job.find(params[:id])
	end

	def update
		if @job.update_attributes(params[:job])
      flash[:notice] = "Your job has been updated!"
      redirect_to @job
    else
    	flash[:error] = "Please fill out the entire job form."
    end
	end

	def destroy
	end
end
