class CartController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def show
  end
  
  def create
    session[:cart] = {} if session[:cart].nil?
    
    option_id = Product.find(params[:product_id]).options.where("option1 = ? AND option2 = ?",params[:option1],params[:option2]).first.id 
    session[:cart][option_id] = params["quantity"]
    redirect_to my_cart_url
  end
  
  def edit
  end
  
  def update
    session[:cart].delete(params["delete_id"])
    session[:cart][params["option_id"]] = params["quantity"]
    redirect_to my_cart_url
  end
  
  def destroy
    session[:cart] = nil
  end
  
end
