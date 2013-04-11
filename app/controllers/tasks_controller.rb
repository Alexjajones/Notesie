class TasksController < ApplicationController

  #Makes authenticate_user! effect the whole application. This will force the user to sign up/log in before the application can be used.
  #Before filter means it is applied to the application before it loads.
  before_filter :authenticate_user!

  #Makes owns_task only effect edit, update and destroy
  before_filter :owns_task, only: [:edit, :update]

  # Passes all of current tasks via the Tasks model into the @tasks hash/array and displays the index view.
  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all

    respond_to do |format|
      format.html # index.html.erb.erb
      format.json { render json: @tasks }
    end
  end

  #Finds the current task id within the current parameter, passes it into @task hash/array and displays that single task via the show view.
  #Also passes current notebook from the Notebooks model into @notebook hash/array.
  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @notebook = Notebook.find(params[:notebook_id])
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end

  #Calls .new to create a new task via the Task model and displays that single task via the new.html.erb view.
  #Also passes current notebook from the Notebooks model into @notebook hash/array.
  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @notebook = Notebook.find(params[:notebook_id])
    @task = Task.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  #Finds the current task id within the current parameter and displays that single task with editing options via the edit.html.erb view, which renders the _form.html.erb as the form.
  # GET /tasks/1/edit
  def edit
    @notebook = Notebook.find(params[:notebook_id])
    @task = Task.find(params[:id])
  end

  #Calls .new to create a new task nested under notebooks, passing the task via the parameter.
  #Also passes current notebook from the Notebooks model into @notebook hash/array
  # POST /tasks
  # POST /tasks.json
  def create
    @notebook = Notebook.find(params[:notebook_id])
    @task = @notebook.tasks.new(params[:task])
    @task.user = current_user

    respond_to do |format|
      if @task.save
        format.html { redirect_to notebook_path(@notebook), notice: 'Task was successfully created.' }
        format.json { render json: @task, status: :created, location: @task }
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  #Update finds the current task id within the current parameter committing any updates on the task on request showing a message on completion.
  #Redirects user to the tasks root /notebooks/:id/tasks/:id
  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to notebook_task_path(@task.notebook, @task), notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  #Finds the current task id within the current parameter and assigns it to @task, then calls destroy on that task.
  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to :back, notice: 'Task was successfully created.' }
      format.json { head :no_content }
    end
  end

  #If the user is not signed in, or the current user does not own the bulletin, redirect them to notebooks page with an error,ensuring complete ownership of bulletins.
  def owns_task
    if !user_signed_in? || current_user != Notebook.find(params[:notebook_id]).user
      redirect_to notebook_path(params[:notebook_id]), alert: 'You cannot do this as you do not own this task'
    end
  end

end
