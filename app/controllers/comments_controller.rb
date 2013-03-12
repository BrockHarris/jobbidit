class CommentsController < ApplicationController
  before_filter :login_required
  
	def create
		@comment = Comment.new(params[:comment])
    if @comment.save
      flash[:notice] = "Your comment has been posted!" 
      redirect_to(:back)
    end
	end

	def destroy
    @comment = Comment.find(params[:id])
    Comment.find(@comment).destroy
    flash[:notice] = "Your bid has been removed." 
    redirect_to(:back)
	end
end
