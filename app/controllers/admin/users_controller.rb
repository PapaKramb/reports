class Admin::UsersController < ApplicationController
  def index
    authorize!
    @users = User.all
  end

  def new
    authorize!
    @user = User.new
  end

  def create
    authorize!
      @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render 'new'
    end
  end

  def destroy
    @user = User.find(params[:id])
    authorize!
    
    @user.destroy
  end

  private

  def user_params
    params.require(:user).permit(:email, :password,
                                 :password_confirmation)
  end
end
