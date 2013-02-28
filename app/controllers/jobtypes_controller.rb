class JobtypesController < ApplicationController
	
	def create
		@jobtype = Jobtype.new(params[:jobtype])
    if @jobtype.save
      flash[:notice] = "Job category added." 
      redirect_to(:back)
    end
	end
end
