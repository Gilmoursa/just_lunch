class UsersController < ApplicationController
 before_action :set_user, only: [:show, :edit] 
  def new
    @user = User.new
  end

  def create
  	@user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to new_user_availability_path(@user), :notice => "Thank you for signing up!"
    else
      render :new
    end
  end

  def show
    
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_update_params)
    redirect_to user_path(@user)
  end

private
	def set_user
    @user = User.find(params[:id])
  end
    
  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation, :birthdate)
  end

  def user_update_params
    params.require(:user).permit(:name, :email)
  end
end