class PostsController < ApplicationController
  def create
    @post = Post.new post_params
    @post.user = current_user
    if @post.save
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_back index_path
    else
      redirect_back fallback_location: index_path
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_back fallback_location: index_path
    end
  end
  
  private
  def post_params
    params.require(:post).permit(:image, :content)
  end
end
