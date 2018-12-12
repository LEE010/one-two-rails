class ProfilesController < ApplicationController
  load_and_authorize_resource
  before_action :set_profile, only: [:show, :edit, :update]
  
  load_and_authorize_resource
  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
  end
  
  # GET /profiles/1
  # GET /profiles/1.json
  def my_profile
    @profile = current_user.profile
  end
  
  def show
    @posts = @profile.user.posts
    @follow_users = @profile.user.follows_by_type('User')
    @follow_stores = @profile.user.follows_by_type('Store')
  end
  
  # def new
  #   @profile = Profile.new
  # 
  
  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  # def create
  #   @profile = Profile.new(profile_params)
  #   @profile.user = current_user

  #   respond_to do |format|
  #     if @profile.save
  #       format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
  #       format.json { render :show, status: :created, location: @profile }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @profile.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # def profile_params
    #   params.require(:profile).permit(:name, :mobile, :birth, :postcode, :address, :address2)
    # end
end
