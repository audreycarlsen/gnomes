class WelcomeController < ApplicationController
  def index
    @posts = Post.all.order('created_at DESC').first(3)
    @tools = Tool.all
    @events = Event.all
    @user = current_user
  end
end
