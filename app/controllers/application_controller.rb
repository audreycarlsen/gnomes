class ApplicationController < ActionController::Base
  require 'barometer'

  protect_from_forgery with: :exception
  before_action :current_user, :set_weather

  def set_weather
    @barometer = Barometer.new('Seattle')
    @weather = @barometer.measure
  rescue Barometer::TimeoutError
    nil
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue ActiveRecord::RecordNotFound
    reset_session
    redirect_to root_path, notice: "You do not exist. Sorry!"
  end
  helper_method :current_user

  def authorize
    redirect_to root_path, notice: 'Please log in!' if current_user.nil?
  end

  def admin_user
    redirect_to root_url unless @current_user.admin == true
  end

  def set_up_admin_index
    @users = User.all
    @tool = Tool.new
    @tools = Tool.all
  end
end
