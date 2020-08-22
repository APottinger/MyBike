class TrailsController < ApplicationController
    before_action :redirect_if_not_logged_in
   before_action :set_trail, only: [:show, :edit, :update]
   before_action :redirect_if_not_trail_author, only: [:edit, :update]

  def index
    if params[:bike_id] && @bike = Bike.find_by_id(params[:bike_id])
       @trails = @bike.trails
    else
      @error = "That bike doesn't exist" if params[:bike_id]
      @trails = trail.all
    end
  end

  def new
    #if it's nested and why find the bike
    if params[:bike_id] && @bike = Bike.find_by_id(params[:bike_id])
      @trail = @bike.trails.build
    else
      @error = "That bike doesn't exist" if params[:bike_id]
      @trail = trail.new
    end
  end

  def create
    @trail = current_user.trails.build(trail_params)
    if @trail.save
      redirect_to trails_path
    else
      render :new
    end
  end


  def show
  end

  def edit
  end

  def update
    if @trail.update(trail_params)
      redirect_to trail_path(@trail)
    else
      render :edit
    end
  end

  private

  def trail_params
    params.require(:trail).permit(:content,:bike_id)
  end

  def set_trail
    @trail = trail.find_by(id: params[:id])
    if !@trail
      flash[:message] = "trail was not found"
      redirect_to trails_path
    end
  end

  def redirect_if_not_trail_author
     redirect_to trails_path if @trail.user != current_user
  end    
end
