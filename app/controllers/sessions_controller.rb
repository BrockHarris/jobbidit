class SessionsController < ApplicationController

  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      session[:user_id] = user.id
    else
      flash[:error] = "There was a problem with your email or password"
    end
    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've been signed out, come back soon!"
    redirect_to root_url
  end

  def sign_in_and_redirect_back_or_default(user, url=request.url)
    session[:user_id] = user.id
    redirect_back_or_default(url)
  end
end
