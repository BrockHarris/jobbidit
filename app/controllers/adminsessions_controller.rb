class AdminsessionsController < ApplicationController
	
	def create
    admin = Admin.authenticate(params[:login], params[:password])
    if admin
      session[:admin_id] = admin.id
    else
      flash[:error] = "There was a problem with your username or password."
    end
    redirect_to admin_path
  end

  def destroy
    session[:admin_id] = nil
    flash[:notice] = "You've been signed out."
    redirect_to admin_path
  end
end
