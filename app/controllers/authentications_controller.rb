class AuthenticationsController < ApplicationController
	before_filter :login_required, :only=>[:destroy]
  
  def index
   @authentications = current_user.authentications if current_user	
  end

  def create
    @omniauth = request.env["omniauth.auth"]
    authentication = Authentication.where(:provider=>@omniauth['provider'], :token=>@omniauth['credentials']['token'],:uid=>@omniauth['uid']).where("user_id IS NOT NULL").first
    if authentication
      flash[:notice] = "Welcome back!"
      sign_in_and_redirect_back_or_default(authentication.user, user_path(authentication.user))
    elsif current_user
      #the user is logged in and trying to add another authentication
      current_user.authentications.create(:provider => @omniauth['provider'], :uid => @omniauth['uid'])
      flash[:notice] = "Authentication successful."
      redirect_to authentications_url
    else
      #request to sign up via with omniauth service.
      if user = User.find_by_email(@omniauth[:info][:email])
        #if the user's email exists, notify and redirect to signin.
        handle_authentication_email_conflict
      elsif user = User.find_by_username(@omniauth[:info][:nickname])
        #else if the omniauth username exists, redirect to a page where they can chose a username.
        handle_authentication_username_conflict
      else
        #else create the user with this username and email, associated auth and sign them in. 
        handle_new_user_creation_through_authentication
      end  
    end
  end

  #this action will attempt to create a new user and associate the authentication record in session.
  def complete_session_authentication
    raise 'No authentication in session' unless session[:pending_authentication_id]
    @user = User.new(params[:user])
    if @user.save
      @user.authentications << Authentication.find(session[:pending_authentication_id])
      session[:pending_authentication_id] = nil #nix the id in session after successful assoc
      sign_in_and_redirect_back_or_default(@user, user_path(@user))
    else
      render :action=>"incomplete_authorization"
    end
  end

  def auth_failure
    flash[:error] = "Authentication Failed"
    redirect_to new_session_url
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end

  private

  def handle_authentication_username_conflict
    flash.now[:notice]="Username #{@omniauth[:info][:nickname]} is already taken, please create an alternate for your account."
    #create an authorization object and store the id in session
    session[:pending_authentication_id] = Authentication.create!(:provider => @omniauth['provider'],:token=>@omniauth['credentials']['token'], :uid =>@omniauth['uid'])
    @user = User.new(:email=>@omniauth[:info][:email]) #create a user object for the form to be rendered.
    render :action=>"incomplete_authorization"
  end

  def handle_authentication_email_conflict
    flash[:notice]="#{@omniauth[:info][:email]} already has an account, signin using your password below."
    redirect_to(signin_path(:email=>user.email))
  end

  def handle_new_user_creation_through_authentication
    username = @omniauth['info']['nickname'] || @omniauth['info']['name']
    user = User.new(:mode=>"service", :email=>@omniauth['info']['email'], :facebook_id => @omniauth['uid'], :token=>@omniauth['credentials']['token'], :username=>username.gsub(/\W/,''))
    user.authentications.build(:provider => @omniauth ['provider'], :uid => @omniauth['uid'], :token=>@omniauth['credentials']['token'])
    user.save!
    flash[:notice] = "Thanks for signing up!"
    sign_in_and_redirect_back_or_default(user, user_path(user))
  end
end
