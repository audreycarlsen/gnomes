class UsersController < ApplicationController
  before_action :set_user

  def edit
  end

  def update
    if @user.update(user_params)
      respond_to do |format|
        format.html { redirect_to :back }
        format.json { head :no_content }
      end
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @user.destroy
    redirect_to :back
  end

  private

  def user_params
    params.require(:user).permit(:email, :phone)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
