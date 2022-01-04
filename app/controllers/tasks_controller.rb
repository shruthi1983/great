class TasksController < ApplicationController
	before_action :find_task,only: [:show,:edit,:update,:destroy]
  before_action :authenticate_user!,except: [:index, :show]
  before_action :correct_user, only: [:show, :edit,:update,:destroy]

  def index
  	 @tasks = Task.all
  end
  
  def show
   
  end
  def new
  	#@task = Task.new
    @task = current_user.tasks.build
  end
  def create
    #@task = Task.new(task_params)
   @task = current_user.tasks.build(task_params)

  	 if @task.save
  	 	  redirect_to @task,notice:"Task created suceesfully"
     else
  	 	  render 'new'
      end
  end
  def edit 
    
  end
  def update
  	  @task = Task.find(params[:id])
  	   if @task.update(task_params)
  	 	  redirect_to @task, notice:" Task was sucessfully updated"
       else
          render 'edit'
       end
  end
  def destroy
   	 @task.destroy
   	 redirect_to root_path,notice: "Task deleted sucessfully"
  end
  def find_task
   	 @task = Task.find(params[:id])
  end

  def correct_user
    @task =current_user.tasks.find_by(id: params[:id])
    redirect_to tasks_path,
    notice:"Not authorize to create" if @task.nil?
    
  end

 private

  def task_params
    params.require(:task).permit(:note,:created_at,:completed_at,:user_id)
  end
end
