class UsersController < ApplicationController
  before_action :set_user
  before_action :valid_user, only: [:show]

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
    @events_users = EventsUser.where(user_id: current_user.id)
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

  def valid_user
    unless current_user && current_user == @user
      redirect_to root_path
    end
  end
end
