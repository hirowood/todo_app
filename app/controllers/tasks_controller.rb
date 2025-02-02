class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :toggle]

  def index
    if params[:query].present?
      @tasks = Task.where("title LIKE ?", "%#{params[:query]}%")
    else
      @tasks = Task.all
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "ToDoを作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "ToDoを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @task.destroy
    redirect_to task_path, notice: "ToDoを削除しました"
  end

  def toggle
    @task.update(completed: !@task.completed)
    redirect_to tasks_path,notice: "ToDoの状態を更新しました"
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :completed)
  end
  
end
