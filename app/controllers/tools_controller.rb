class ToolsController < ApplicationController
  before_action :admin_user, except: [:show, :reserve_tool, :return_tool]
  before_action :set_tool, only: [:show, :edit, :destroy, :update, :reserve_tool, :return_tool]
  before_action :authorize

  def new
    @tool = Tool.new
  end

  def edit
  end

  def create
    @tool = Tool.new(tool_params)
    if @tool.save
      redirect_to tool_path(@tool), notice: '#{@tool.title} has been successfully added to the toolset!'
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

   def reserve_tool
    @tool.update(user_id: current_user.id)
    respond_to do |format|
      format.html {redirect_to :back}
      format.json {render json: @tool}
    end
  end

   def return_tool
    @tool.update(user_id: nil)
    respond_to do |format|
      format.html {redirect_to :back, notice: "Thank you, the tool is returned!"}
      format.json {render json: @tool}
    end
  end


  private

  def tool_params
    params.require(:tool).permit(:title, :user_id)
  end

  def admin_user
    redirect_to root_url unless current_user && current_user.admin == true
  end

  def set_tool
    @tool = Tool.find(params[:id])
  end
end
