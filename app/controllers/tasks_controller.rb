class TasksController < ApplicationController
  def index
    @tasks = Task.where(completed: 0).order("priority DESC")
    @completed_tasks = Task.where(completed: 1).order("updated_at")
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
    if @task.errors.empty?
      redirect_to root_path
    else
      render "new"
    end
  end

  def update
    @task = Task.find(params[:id])
    @task.update_attributes task_params
    if @task.errors.empty?
      redirect_to root_path
    else
      render "edit"
    end
  end

  def edit
    @task = Task.find (params[:id])
  end

  def show
    unless @task = Task.where(id: params[:id]).first
      render text: "Page not found", status: 404
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to root_url
  end

  def completed
    @task = Task.find params[:id]
    @task = complete!
    redirect_to tasks_path
  end

  private
  def task_params
    params.require(:task).permit([:title, :description, :priority, :completed_to, :completed ])
  end
end
