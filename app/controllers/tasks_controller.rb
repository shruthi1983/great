class TasksController < ApplicationController
	before_action :find_task,only: [:show,:edit,:update,:destroy]
    before_action :authenticate_user!,except: [:index, :show]
    before_action :correct_user, only: [:edit,:update,:destroy]

  def index
  	 @tasks = Task.all
  end
  
  def show
  	 @task = Task.find(params[:id])
  end
  def new
  	#@task = Task.new
    @task = current_user.tasks.build
  end
  def create
     #@task = Task.new(task_params)
     @task = current_user.tasks.build(task_params)
     @task.user_id =current_user.id
  	 if @task.save
  	 	  redirect_to @task,notice:"task is created suceesfully"
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
  def correct_user
    @tasks =current_user.tasks.find_by(id: params[:id])
    redirect_to tasks_path,notice:"not authorize to edit" if @task.nil?
  end
 private
  def task_params
     params.require(:task).permit(:note,:created_at,:completed_at,:user_id)
  end
end
