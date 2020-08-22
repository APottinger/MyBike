class BikesController < ApplicationController
    before_action :redirect_if_not_logged_in

  def new
    if params[:user_id] && @user = User.find_by_id(params[:user_id])
      @bike = @user.bikes.build
    else
      @bike = bike.new
    end
    @bike.build_category
  end

  def index
    if params[:user_id] && @user = User.find_by_id(params[:user_id])
       @bikes = @user.bikes.alpha
    else
      @error = "That user doesn't exist" if params[:user_id]
      @bikes = bike.alpha.includes(:category, :user)
    end

    @bikes = @bikes.search(params[:q].downcase) if params[:q] && !params[:q].empty?
    @bikes = @bikes.filter(params[:bike][:category_id]) if params[:bike] && params[:bike][:category_id] != ""

  end


  def create
    @bike = current_user.bikes.build(bike_params)
    if @bike.save
      redirect_to bikes_path
    else
      render :new
    end
  end


  def edit
    @bike = bike.find_by_id(params[:id])
    redirect_to bikes_path if !@bike || @bike.user != current_user
    @bike.build_category if !@bike.category
  end

  def update
     @bike = bike.find_by(id: params[:id])
     redirect_to bikes_path if !@bike || @bike.user != current_user
    if @bike.update(bike_params)
      redirect_to bike_path(@bike)
    else
      render :edit
    end
  end



  def show
    @bike = bike.find_by_id(params[:id])
    redirect_to bikes_path if !@bike
  end


  private

  def bike_params
    params.require(:bike).permit(:title,:content, :category_id, category_attributes: [:name])
  end
end
