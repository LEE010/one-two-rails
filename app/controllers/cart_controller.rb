class CartController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_cart, only: [:show, :create]
  before_action :set_option_id, only: [:update, :create]
  
  
  def show
    @cart_items = session[:cart]
    @total_price = 0
 
    @cart_items.each do |item_id, quantity|
      item = Option.find(item_id)
      @total_price += item.product.price.to_i * quantity.to_i
    end
    
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  def create
    
    session[:cart][@option_id] = params["quantity"]
    redirect_to my_cart_url
  end
  
  def edit
    @option = Option.find(params[:option_id])
    @product = @option.product
    @options1 = @product.options.select(:option1).distinct
    @options2 = @product.options.select(:option2).distinct
    
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  def update
    
    session[:cart].delete(params[:delete_id])
    session[:cart][@option_id] = params[:quantity]
    redirect_to my_cart_url
  end
  
  def destroy_item
    session[:cart].delete(params[:id])
    redirect_to my_cart_url
  end
  
  def destroy
    session[:cart] = nil
  end
  
  private
  def set_cart
    session[:cart] = {} if session[:cart].nil?
  end
  
  def set_option_id
    @option_id = Product.find(params[:product_id]).options.where("option1 = ? AND option2 = ?",params[:option1],params[:option2]).first.id
  end
end
