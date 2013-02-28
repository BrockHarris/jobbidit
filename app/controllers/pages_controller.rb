class PagesController < ApplicationController
before_filter :catch_users_missing_roles
	
	def admin_panel
		@jobtypes = Jobtype.all
		@jobtype = Jobtype.new
	end

	def contact
		@message = Message.new
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
	end

	def about
	end

	def privacypolicy
	end
end
