class AvailabilityController < ApplicationController
  def edit
    @user = User.find(params[:user_id])
    @availability = Availability.find(params[:id])
  end

  def update
    @availability = Availability.find(params[:id])
    @availability.update(availability_params)
    redirect_to user_path(params[:user_id])
  end

  private

  def availability_params
    params.require(:availability).permit(:time, :location)
  end
end