class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :get_project

  # GET /projects/#/tasks
  # GET /projects/#/tasks.json
  def index
#    @tasks = Task.all
    @tasks = @project.tasks
  end

  # GET /projects/#/tasks/1
  # GET /projects/#/tasks/1.json
  def show
  end

  # GET /projects/#/tasks/new
  def new
    @task = Task.new
  end

  # GET /projects/#/tasks/1/edit
  def edit
  end

  # POST /projects/#/tasks
  # POST /projects/#/tasks.json
  def create
    @task = Task.new(task_params)
    if @task.buffer == :false
      :update_buffer
    end
    respond_to do |format|
      if @task.save
        format.html { redirect_to project_task_url, notice: 'Task was successfully created.' }
        format.json { render action: 'show', status: :created, location: @task }
      else
        format.html { render action: 'new' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/#/tasks/1
  # PATCH/PUT /projects/#/tasks/1.json
  def update
    if @task.buffer == false
      :update_buffer
    end
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to project_tasks_url, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/#/tasks/1
  # DELETE /projects/#/tasks/1.json
  def destroy
    @task.destroy
    if @task.buffer == false
      :update_buffer
    end
    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end
  
  def update_buffer
    @grouped_tasks = Task.find_by :buffer => false, :parent_id => @task.parent_id
    @buffer_value = @grouped_tasks.sum(:error)
    #TODO If buffer exists, update the values
    if @buffer.exists?
      
    else
      Task.new(:name => 'Buffer', :Lower => @buffer_value, :upper => @buffer_value, :buffer => true)
      Task.save
    end
    #TODO If not, then create a buffer entry
    
    return
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = @project.task.find(params[:id])
      @buffer = @project.task.find_by :buffer => true, :parent_id => @task.parent_id
    end
    
    def get_project
      @project = Project.find(params[:project_id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :upper, :lower)
    end
end
