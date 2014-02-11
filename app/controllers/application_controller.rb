class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound
    reset_session
    redirect_to root_path, notice: "You do not exist. Sorry!"
  end
  helper_method :current_user

  def authorize
    redirect_to login_url, notice: 'Please log in!' if current_user.nil?
  end
end
