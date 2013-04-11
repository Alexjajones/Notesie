class NotebooksController < ApplicationController
  #Makes authenticate_user! effect the whole application. This will force the user to sign up/log in before the application can be used.
  #Before filter means it is applied to the application before it loads.
  before_filter :authenticate_user!

  #Makes owns_notebook only effect edit, update and destroy
  before_filter :owns_notebook, only: [:edit, :update, :destroy]

  #Makes owns_notebook only effect new
  before_filter :is_tutor, only: [:new]

  # Passes all of current notebooks via the Notebooks model into the @notebooks hash/array and displays the index view.
  # Also passes everything from the Bulletins model into @bulletins hash/array
  # GET /notebooks
  # GET /notebooks.json
  def index
    @notebooks = Notebook.all
    @bulletins = Bulletin.all

    respond_to do |format|
      format.html
      format.json { render json: @notebooks }
    end
  end

  #Finds the current notebook id within the current parameter, passes it into @notebook hash/array and displays that single notebook via the show view.
  # GET /notebooks/1
  # GET /notebooks/1.json
  def show
    @notebook = Notebook.find(params[:id])


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @notebook }
    end
  end

  #Calls .new to create a new notebook via the Notebook model and displays that single notebook via the new.html.erb view.
  # GET /notebooks/new
  # GET /notebooks/new.json
  def new
    @notebook = Notebook.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @notebook }
    end
  end

  #Finds the current notebook id within the current parameter and displays that single notebook with editing options via the edit.html.erb view, which renders the _form.html.erb as the form.
  # GET /notebooks/1/edit
  def edit
    @notebook = Notebook.find(params[:id])
  end

  #Calls .new to create a new notebook via the Notebook model, also assigning the current users ID to the user ID field within notebooks.
  #This is used to ensure users only see what's meant for them.
  #Also renders out a pages that tells users that creation was complete
  # POST /notebooks
  # POST /notebooks.json
  def create
    @notebook = Notebook.new(params[:notebook])
    @notebook.user = current_user

    respond_to do |format|
      if @notebook.save
        format.html { redirect_to @notebook, notice: 'Notebook was successfully created.' }
        format.json { render json: @notebook, status: :created, location: @notebook }
      else
        format.html { render action: "new" }
        format.json { render json: @notebook.errors, status: :unprocessable_entity }
      end
    end
  end

  #Update finds the current notebook id within the current parameter committing any updates on the notebook on request showing a message on completion.
  # PUT /notebooks/1
  # PUT /notebooks/1.json
  def update
    @notebook = Notebook.find(params[:id])

    respond_to do |format|
      if @notebook.update_attributes(params[:notebook])
        format.html { redirect_to @notebook, notice: 'Notebook was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @notebook.errors, status: :unprocessable_entity }
      end
    end
  end

  #Finds the current notebook id within the current parameter and assigns it to @notebook, then calls destroy on that notebook.
  # DELETE /notebooks/1
  # DELETE /notebooks/1.json
  def destroy
    @notebook = Notebook.find(params[:id])
    @notebook.destroy

    respond_to do |format|
      format.html { redirect_to notebooks_url }
      format.json { head :no_content }
    end
  end

  #If the user is not signed in, or the current user does not own the notebook, redirect them to notebooks page with an error, ensuring complete ownership of notebooks
  def owns_notebook
      if !user_signed_in? || current_user != Notebook.find(params[:id]).user
        redirect_to notebook_path,  alert: 'You cannot do this as you do not own this notebook'
      end
  end

  #If the user is not signed in, or the current user is not a tutor, redirect them to notebooks page with an error
  def is_tutor
    if !user_signed_in? || current_user.tutor != true
      redirect_to notebook_path, lert: 'You must be a tutor to do this'
    end
  end

end
