class FollowsController < ApplicationController
  def toggle
    votable = params[:followable].singularize.classify.constantize.find(params[:id])
   
    if current_user.following?(votable)
      current_user.stop_following(votable)
    else
      current_user.follow(votable)
    end
    
    redirect_back(fallback_location: current_user.profile)
  end
end
