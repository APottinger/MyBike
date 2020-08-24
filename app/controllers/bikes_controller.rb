class BikesController < ApplicationController
    before_action :redirect_if_not_logged_in

  def new
    if params[:user_id] && @user = User.find_by_id(params[:user_id])
      @bike = @user.bikes.build
    else
      @bike = Bike.new
    end
    @bike.build_user
  end

  def index
    if params[:user_id] && @user = User.find_by_id(params[:user_id])
       @bikes = @user.bikes.alpha_order
    else
      @error = "That user doesn't exist" if params[:user_id]
      @bikes = Bike.alpha_order.includes(:user)
    end

  end


  def create
    @bike = current_user.bikes.build(bike_params)
    #byebug
    if @bike.save
      redirect_to bikes_path
    else
      render :new
    end
  end


  def edit
    @bike = Bike.find_by_id(params[:id])
    redirect_to bikes_path if !@bike || @bike.user != current_user
    
  end

  def update
     @bike = Bike.find_by(id: params[:id])
     redirect_to bikes_path if !@bike || @bike.user != current_user
    if @bike.update(bike_params)
      redirect_to bike_path(@bike)
    else
      render :edit
    end
  end



  def show
    @bike = Bike.find_by_id(params[:id])
    redirect_to bikes_path if !@bike
  end


  private

  def bike_params
    params.require(:bike).permit(:name,:type, :quality)
  end
end
