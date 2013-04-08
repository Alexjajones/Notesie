class NotebooksController < ApplicationController

  before_filter :authenticate_user!, only: [:index, :new, :create, :edit, :update, :destroy]
  before_filter :owns_notebook, only: [:edit, :update, :destroy]
  before_filter :is_tutor, only: [:new]
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

  # GET /notebooks/1
  # GET /notebooks/1.json
  def show
    @notebook = Notebook.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @notebook }
    end
  end

  # GET /notebooks/new
  # GET /notebooks/new.json
  def new
    @notebook = Notebook.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @notebook }
    end
  end

  # GET /notebooks/1/edit
  def edit
    @notebook = Notebook.find(params[:id])
  end

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

  private

  def owns_notebook

    #If the user is not signed in, or the current user does not own the notebook, redirect them to notebooks page with an error
      if !user_signed_in? || current_user != Notebook.find(params[:id]).user
        redirect_to notebook_path,  alert: 'You cannot do this as you do not own this notebook'
      end
  end

  def is_tutor

    #If the user is not signed in, or the current user is not a tutor, redirect them to notebooks page with an error
    if !user_signed_in? || current_user.tutor != true
      redirect_to notebook_path, lert: 'You must be a tutor to do this'
    end
  end

end
