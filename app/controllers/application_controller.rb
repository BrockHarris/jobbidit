class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all 
  helper_method :current_user
  helper_method :admin_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def admin_user
    @admin_user ||= Admin.find(session[:admin_id]) if session[:admin_id]
  end

  def store_location(url=request.url) # Might be able to nix
    session[:return_to] = url
  end

  def sign_in_and_redirect_back_or_default(user, url=request.url)
    session[:user_id] = user.id
    redirect_to root_url
  end

  def sign_admin_in(admin)
    session[:admin_id] = admin.id
    redirect_to admin_path
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  def login_required
    unless current_user
      store_location
      flash[:notice] = "Please sign in first!"
      redirect_to signin_url
      return false
    end
  end

  # The following 3 MIGHT be used for admins #

  def access_denied(msg=MESSAGE_INSUFFICIENT_RIGHTS)
    flash[:error] = msg
    redirect_to root_url
    return false
  end
  
  def admin_login_required
    access_denied unless current_user.try(:admin)
  end
  
  def admin_logged_in?
    access_denied unless current_user.try(:admin)
  end

  private

  def catch_users_missing_roles
    if current_user && current_user.role.blank?
      redirect_to usertype_path
    end
  end
end
