class FollowsController < ApplicationController
  def toggle
    votable = params[:votable].singularize.classify.constantize.find(params[:id])
   
    if current_user.following?(votable)
      current_user.stop_following(votable)
    else
      current_user.follow(votable)
    end
    
    redirect_to votable
  end
end
