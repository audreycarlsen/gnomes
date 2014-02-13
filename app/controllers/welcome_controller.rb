class WelcomeController < ApplicationController
  def index
     @posts = Post.all.order('created_at DESC')
     @tools = Tool.all
     @events = Event.all
  end
end
