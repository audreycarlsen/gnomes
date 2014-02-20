class AdminController < ApplicationController
  before_action :admin_user

  def index
    set_up_admin_index
    @post = Post.new
  end

  def create
    @user = User.find(params[:id])
    @user.admin = true
    @user.save
    
    redirect_to :back
  end

  def destroy
    @user = User.find(params[:id])
    @user.admin = false
    @user.save

    redirect_to :back
  end
end
