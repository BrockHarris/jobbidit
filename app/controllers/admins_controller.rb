class AdminsController < ApplicationController

	def create
    @admin = Admin.new(params[:admin])
    if @admin.save
      flash[:notice] = "Admin user created."
      sign_admin_in(@admin)
    else
    	flash[:notice] = "Please double-check the form."
    	redirect_to (:back)
    end
  end
end
