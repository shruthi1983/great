class TasksController < ApplicationController
	before_action :find_task,only: [:show,:edit,:update,:destroy]
    before_action :authenticate_user!,except: [:index, :show]
 

  def index
  	 @tasks = Task.all
  end
  
  def show
  	 @task = Task.find(params[:id])
  end
  def new
  	 @task = Task.new
  end
  def create
     @task = Task.new(task_params)
  	   if @task.save
  	 	  redirect_to @task
      else
  	 	  render 'new'
      end
  end
  def edit 
     @task = Task.find(params[:id])
  end
  def update
  	  @task = Task.find(params[:id])
  	   if @task.update(task_params)
  	 	  redirect_to @task
       else
          render 'edit'
       end
  end
  def destroy
   	 @task.destroy
   	 redirect_to root_path
  end
  def find_task
   	 @task = Task.find(params[:id])
  end
 private
  def task_params
     params.require(:task).permit(:note,:created_at,:completed_at)
  end
end
