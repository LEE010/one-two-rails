class CommentsController < ApplicationController

  def index
  end
  
  def new
    @commnet = commentable.comments.new
  end
  
  def create
    if Comment.create(comment_params)
      redirect_back(fallback_location: root_path)
    end
  end
  
  def edit
    @comment = Comment.find(params[:id])
  end
  
  def update
    if Comment.update(comment_params)
      redirect_to product_path(comment_params[:commentable_id])
    else
      redirect_to root_path
    end
  end
  
  def destroy
    
  end
  
  private
  def comment_params
    params.require(:comment).permit(:commentable_type, :commentable_id, :title, :comment, :user_id)
  end
end
