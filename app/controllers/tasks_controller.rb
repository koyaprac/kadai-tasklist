class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :show, :update, :destroy]
  
  def index
    @tasks = Task.all
  end
  
  
  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    
    if @task.save
      flash[:success] = "タスクが正常に生成されました"
      redirect_to @task
    else
      flash.now[:danger] = "タスクが正常に生成されませんでした"
      render :new
    end
  end
  
  
  def new
    @task = Task.new
  end
  
  
  def edit
  end


  def show
  end
  
  
  def update
    
    if @task.update(task_params)
      flash[:success] = "正常更新"
      redirect_to @task
    else
      flash.now[:danger] = "更新失敗"
      render :edit
    end
  end
  
  
  def destroy
    @task.destroy
    
    flash[:success] = "正常に削除されました　"
    redirect_to root_url
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  # Strong Params
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
