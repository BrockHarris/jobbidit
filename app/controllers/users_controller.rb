class UsersController < ApplicationController
	before_filter :login_required, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update, :destroy]
  before_filter :catch_users_missing_roles, :only => :show

  def show
  end

  def profile
  end 

  def usertype
    @user = current_user
    @go_to_root = true
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      @user.activate!
      flash[:notice] = "Thanks for signing up!"
      sign_in_and_redirect_back_or_default(@user, users_path(@user))
    else
      flash[:error] = "There was a problem with your info, please try again."
      redirect_to signup_path
    end
  end
  
  def settings
    @user = current_user
  end

  def assist
    @email = params[:email]
    if request.post? && !@email.blank?
      user = User.find_by_email(@email)
      if user.nil? || (!user.active? && !user.pending?)
        flash.now[:error] = "We don't have an active account for '#{@email}'. Please try again, or contact us if you need assistance."
      else
        user.send_reset_password_email!
        flash[:notice] = "An email has been sent to #{@email}.<br />".html_safe
        flash[:notice] << "Follow the instructions in the email to reset your password."
        redirect_to root_url
      end
    end
  end

  def reset
    @user = User.find_by_id(params[:id])
    code = params[:reset_code]
    if request.post?
      if !params[:password].nil?
        @user.password = params[:password]
        @user.password_confirmation = params[:password_confirmation]

        # If the password has already been set, this doesn't normally cause
        # a validation error, but we want it to here.
        if @user.valid? && @user.password.blank?
          @user.errors.add(:password, ActiveRecord::Errors.default_error_messages[:blank])
        end

        if @user.errors.empty?
          @user.reset_code = nil
          @user.reset_code_at = nil
          @user.save!
          if @user.pending?
            User.transaction do
              @user.activate!
            end
          end
          flash[:notice] = "Your password has been changed. Please log in to continue."
          redirect_to root_url
        end
      else
        render :action=>"reset"
      end
    elsif request.get?
      if @user.blank? || code.blank?
        flash[:error] = "The link from your password reset may have been cut off. Try to copy and paste the entire URL into your browser, or send a new email below. Please contact us if you continue to have trouble."
        redirect_to assist_path
        return
      end
    end
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = "Your account has been updated!"
      if @go_to_root = true
        redirect_to root_url
      else
        redirect_to (:back)
      end
    else
    	flash[:error] = "There was a problem with your info, please try again."
    end
  end
  
  def destroy
    User.find(@user).destroy
    @user = User.find(params[:id])
    flash[:success] = "User has been removed."
    redirect_to(:back)
  end

  private

  def correct_user
    @user = current_user
    redirect_to(root_path) unless current_user==@user
  end
end
