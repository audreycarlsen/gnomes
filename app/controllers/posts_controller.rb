class PostsController < ApplicationController
  before_action :admin_user, except: :index


  def index
  end

  def new
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

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
