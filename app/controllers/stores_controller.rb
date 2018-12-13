class StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update, :manage]
  before_action :has_store, only: [:new, :create]
  before_action :check_owner, only: [:edit, :update ]
  load_and_authorize_resource
  # GET /stores
  # GET /stores.json
  def index
    @stores = Store.all
  end

  # GET /stores/1
  # GET /stores/1.json
  def show
    @products = @store.products
  end

  # GET /stores/new
  def new
    @store = Store.new
  end

  # GET /stores/1/edit
  def edit
  end
  
  def management
    @products = @store.products.order(updated_at: :desc)
    
  end
  # POST /stores
  # POST /stores.json
  def create
    @store = Store.new(store_params)
    @store.user = current_user

    respond_to do |format|
      if @store.save
        current_user.add_role "seller"
        format.html { redirect_to @store, notice: 'Store was successfully created.' }
        format.json { render :show, status: :created, location: @store }
      else
        format.html { render :new }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stores/1
  # PATCH/PUT /stores/1.json
  def update
    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to @store, notice: 'Store was successfully updated.' }
        format.json { render :show, status: :ok, location: @store }
      else
        format.html { render :edit }
        format.json { render json: @store.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stores/1
  # DELETE /stores/1.json

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_store
      @store = Store.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def store_params
      params.require(:store).permit(:name, :image, :regist_number, :postcode, :address, :address2, :phone_number, :account_number, :user_id)
    end

    def has_store
      redirect_to current_user.store unless current_user.store.nil?
    end
    
    def check_owner
      unless @store.user == current_user
        if current_user.store.nil?
          redirect_to new_store_url
        else
          redirect_to current_user.store 
        end
      end
    end
end
