class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /products
  # GET /products.json
  def index
    @follow_stores = current_user.follows_by_type('Store')
    @stores = []
    @follow_stores.each do |followable|
      @stores.append followable.followable_id
    end
    
    @products = Product.where(store_id: @stores).order(updated_at: :desc)
    
    
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @comments = @product.comments
    @options1 = @product.options.select(:option1).distinct
    @options2 = @product.options.select(:option2).distinct
    
  end

  # GET /products/new
  def new
    @product = current_user.store.products.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = current_user.store.products.new(product_params)

    if @product.save
      redirect_to @product, alert: 'Product was successfully created.'
    else
      render 'new'
    end

  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :price, :image, :info, :store_id, options_attributes: [:option1, :option2, :stock, :code])
    end

end
