class PagesController < ApplicationController
before_filter :catch_users_missing_roles
	
	def admin_panel
		@new_admin = Admin.new
		@jobtypes = Jobtype.all
		@jobtype = Jobtype.new
		@page = Page.new
		@pages = Page.all
		@users = User.all
	end

	def create
    @page = Page.new(params[:page])
    if @page.save
      flash[:notice] = "Page customized!"
      redirect_to (:back)
    else
      flash[:error] = "Please don't leave any blank fields."
      redirect_to (:back)
    end
  end

  def upgrade
  end

  def estimator
  end

	def contact
		@message = Message.new
		@page = Page.find_by_name('contact')
	end

	def home
		@user = User.new
	end

	def homeowners
		@user = User.new
  	redirect_to root_url if current_user
	end

	def contractors
		@user = User.new
  	redirect_to root_url if current_user
	end

	def faq
		@page = Page.find_by_name('faq')
	end

	def about
		@page = Page.find_by_name('about')
	end

	def privacypolicy
		@page = Page.find_by_name('privacypolicy')
	end

	def edit
		@page = Page.find(params[:id])
	end

	def update
		@page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      flash[:notice] = "Page updated!"
      redirect_to admin_path
    else
    	flash[:error] = "Please don't leave any blank fields."
    	redirect_to (:back)
    end
  end
end
