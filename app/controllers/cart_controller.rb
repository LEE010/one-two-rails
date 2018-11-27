class CartController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def show
  end
  
  def new
   
  end
  
  def create
    session[:cart] = {} if session[:cart].nil?
    session[:cart][params["option_id"]] = params["quantity"]
    redirect_to my_cart_url
  end
  
  def edit
  end
  
  def update
    session[:cart].delete("#{delete_id}")
    session[:cart][params["option_id"]] = params["quantity"]
    redirect_to my_cart_url
  end
  
  # private
  # def item_params
  #   params.require("cart_item").permit(cart_key: [:option_id, :quantity])
  # end
end
