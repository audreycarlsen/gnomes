class ToolsController < ApplicationController
   before_action :admin_user, except: [:index, :show]
  before_action :set_tool, only: [:show, :edit, :destroy, :update]

  def index
    @tools = Tool.all
  end

  def new
    @tool = Tool.new
  end

  def edit
  end

  def create
    @tool = Tool.new(tool_params)
    if @tool.save
      redirect_to tool_path(@tool), notice: '#{tool.title} has been successfully added to the toolset!'
    else
      render :new
    end
  end

  def show
  end

  def update
    if @tool.update(tool_params)
      redirect_to tool_path(@tool)
    else
      render :edit
    end
  end

  def destroy
     @tool.destroy
     redirect_to tools_path
  end

  private

  def tool_params
    params.require(:tool).permit(:title, :user_id)
  end

  def admin_user
    redirect_to root_url unless @current_user.admin == true
  end

  def set_tool
    @tool = Tool.find(params[:id])
  end
end
