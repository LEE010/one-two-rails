class HomeController < ApplicationController
  
  def main
    
  end
  
  def index
    @time_line_items = []
    follows = current_user.all_follows
    
    follows.each do |f|
      followable = f[:followable_type].singularize.classify.constantize.find(f[:followable_id])
      if f[:followable_type] == "Store"
        # followable.products.where("updated_at >= ?",Date.today).each do |item| #today update itmes!
        followable.products.each do |item| #all items
          @time_line_items.append item
        end
      # elsif f[:followable_type] == "User"
        # followable.posts.where("updated_at >= ?",Date.today).each do |item| #today update itmes!
        # followable.posts.each do |item| #all items
        #   @time_line_items.append item
        # end
      end
    end
    @time_line_items.sort_by!{ |item| item[:updated_at] }.reverse!
    # debugger
  end
  
end
