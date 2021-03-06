class JobsController < ApplicationController
	before_filter :login_required

	def index
		@search = Job.search do
  		fulltext params[:search]
  	end
  	@jobs = @search.results
		@jobtypes = Jobtype.all
    @user = current_user
		@job = Job.new
		1.times { @job.jobphotos.build }
		@posted_jobs = @user.jobs
		@jobs_tab_active = true
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
		@bid = Bid.new
		@bidder = current_user
		@bids = @job.bids
		@jobphotos = Jobphoto.where(:job_id => @job.id)
	end

	def edit
		@job = Job.find(params[:id])
		@jobtypes = Jobtype.all
  end

	def update
		@job = Job.find(params[:id])
		if @job.update_attributes(params[:job])
      flash[:notice] = "Your job has been updated!"
      redirect_to @job
    else
    	flash[:error] = "Please fill out the entire job form."
    end
	end

	def destroy
		@job = Job.find(params[:id])
    Job.find(@job).destroy
    flash[:success] = "Your job has been deleted."
    redirect_to jobspage_path
  end
end
