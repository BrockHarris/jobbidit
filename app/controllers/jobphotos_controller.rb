class JobphotosController < ApplicationController
	def show
		@jobphoto = Jobphoto.find(params[:id])
	end
end
