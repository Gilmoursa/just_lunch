class AvailabilityController < ApplicationController
  def edit
    @user = User.find(params[:user_id])
    @availability = Availability.find(params[:id])
  end

  def update
    binding.pry
  end
end