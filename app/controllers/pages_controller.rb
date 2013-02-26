class PagesController < ApplicationController
before_filter :catch_users_missing_roles

	def home
		@user = User.new
	end
end
