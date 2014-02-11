class PostsController < ApplicationController
  before_action :admin_user, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :destroy, :update]


  def index
    @post = Post.all
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path, notice: 'Post has been successfully created!'
    else
      render :new
    end
  end

  def show
  end

  def update
    if @post.update(event_params)
      redirect_to event_path(@event)
    else
      render :edit
    end
  end

  def destroy
     @post.destroy
     redirect_to root_url
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def admin_user
    redirect_to root_url unless @current_user.admin == true
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
