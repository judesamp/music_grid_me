class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      gflash notice: "You've signed up and we've logged you in."
      redirect_to root_path 
    else
      gflash notice: "We were unable to create your account. Please try again."
      redirect_to root_path
    end
  end

  def dashboard
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password_confirmation, :password)
  end

end