class CommentsController < ApplicationController
  load_and_authorize_resource
  
  def index
  end
  
  def new
    @commnet = commentable.comments.new
  end
  
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_back(fallback_location: root_path)
    end
  end
  
  def edit
    @comment = Comment.find(params[:id])
  end
  
  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_back fallback_location: index_path
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_back fallback_location: index_path
    end
  end
  
  private
  def comment_params
    params.require(:comment).permit(:commentable_type, :commentable_id, :title, :comment)
  end
end
