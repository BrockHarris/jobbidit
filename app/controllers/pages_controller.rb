class PagesController < ApplicationController
before_filter :catch_users_missing_roles
	
	def contact
		@message = Message.new
	end

	def home
		@user = User.new
	end

	def homeowners
	end

	def contractors
	end

	def faq
	end

	def about
	end

	def privacypolicy
	end
end
