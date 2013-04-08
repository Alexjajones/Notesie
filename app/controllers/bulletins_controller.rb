class BulletinsController < ApplicationController

  before_filter :authenticate_user!, only: [:index, :new, :create, :edit, :update, :destroy]
  before_filter :owns_bulletin, only: [:edit, :update, :destroy]
  before_filter :is_tutor, only: [:new]
  # GET /bulletins
  # GET /bulletins.json
  def index
    @bulletins = Bulletin.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bulletins }
    end
  end

  # GET /bulletins/1
  # GET /bulletins/1.json
  def show
    @bulletin = Bulletin.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bulletin }
    end
  end

  # GET /bulletins/new
  # GET /bulletins/new.json
  def new
    @bulletin = Bulletin.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bulletin }
    end
  end

  # GET /bulletins/1/edit
  def edit
    @bulletin = Bulletin.find(params[:id])
  end

  # POST /bulletins
  # POST /bulletins.json
  def create
    @bulletin = Bulletin.new(params[:bulletin])
    @bulletin.user = current_user

    respond_to do |format|
      if @bulletin.save
        format.html { redirect_to @bulletin, notice: 'Bulletin was successfully created.' }
        format.json { render json: @bulletin, status: :created, location: @bulletin }
      else
        format.html { render action: "new" }
        format.json { render json: @bulletin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bulletins/1
  # PUT /bulletins/1.json
  def update
    @bulletin = Bulletin.find(params[:id])

    respond_to do |format|
      if @bulletin.update_attributes(params[:bulletin])
        format.html { redirect_to @bulletin, notice: 'Bulletin was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @bulletin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bulletins/1
  # DELETE /bulletins/1.json
  def destroy
    @bulletin = Bulletin.find(params[:id])
    @bulletin.destroy

    respond_to do |format|
      format.html
      format.json { head :no_content }
    end
  end


  #If the user is not signed in, or the current user does not own the notebook, redirect them to notebooks page with an error
  def owns_bulletin
    if !user_signed_in? || current_user != Bulletin.find(params[:id]).user
      redirect_to notebooks_path(params[:notebook_id]), alert: 'You cannot do this as you do not own this bulletin'
    end
  end

  #If the user is not signed in, or the current user is not a tutor, redirect them to notebooks page with an error
  def is_tutor
    if !user_signed_in? || current_user.tutor != true
      redirect_to notebook_path, alert: 'You must be a tutor to do this'
    end
  end

end
