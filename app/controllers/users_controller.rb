class UsersController < ApplicationController
  before_action :set_user

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to :back
    else
      render :edit
    end
  end

  def show
  end

  private

  def user_params
    params.require(:user).permit(:email, :phone)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
