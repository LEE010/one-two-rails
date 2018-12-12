class VotesController < ApplicationController
    def like
     
      # sql = "Select * From #{params[:votable]}s Where #{params[:votable]}.id=#{params[:id]}"
      # votable = ActiveRecord::Base.connection.find_by_sql(sql)
      votable = params[:votable].singularize.classify.constantize.find(params[:id])
      votable.liked_by current_user
      redirect_back(fallback_location: index_path)
    end
    
    def unlike
      votable = params[:votable].singularize.classify.constantize.find(params[:id])
      votable.unliked_by current_user
      redirect_back(fallback_location: index_path)
    end
    
    def thumb_up
      votable = params[:votable].singularize.classify.constantize.find(params[:id])
      votable.undisliked_by current_user
      redirect_back(fallback_location: index_path)
    end
    
    def thumb_down
      votable = params[:votable].singularize.classify.constantize.find(params[:id])
      votable.disliked_by current_user
      redirect_back(fallback_location: index_path)
    end
    
    
end
