class BulletinsController < ApplicationController
  #Makes authenticate_user! effect the whole application. This will force the user to sign up/log in before the application can be used.
  #Before filter means it is appplied to the application before it loads.
  before_filter :authenticate_user!

  #Makes owns_notebook only effect edit, update and destroy
  before_filter :owns_bulletin, only: [:edit, :update, :destroy]

  #Makes owns_notebook only effect new
  before_filter :is_tutor, only: [:new]

  # Passes all of current bulletins via the Bulletin model into the @bulletins hash/array and displays the index view.
  # GET /bulletins
  # GET /bulletins.json
  def index
    @bulletins = Bulletin.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bulletins }
    end
  end

  #Finds the current @bulletin id within the current parameter, passes it into @bulletin hash/array and displays that single bulletin via the show.html.erb view.
  # GET /bulletins/1
  # GET /bulletins/1.json
  def show
    @bulletin = Bulletin.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bulletin }
    end
  end

  #Calls .new to create a new bulletin via the Bulletin model and displays that single bulletin via the new.html.erb view.
  # GET /bulletins/new
  # GET /bulletins/new.json
  def new
    @bulletin = Bulletin.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bulletin }
    end
  end

  #Finds the current bulletin id within the current parameter and displays that single bulletin with editing options via the edit.html.erb view, which renders the _form.html.erb as the form.
  # GET /bulletins/1/edit
  def edit
    @bulletin = Bulletin.find(params[:id])
  end

  #Calls .new to create a new bulletin via the Bulletin model, also assigning the current users ID to the user ID field within bulletins.
  #This is used to ensure users only see what's meant for them.
  #Also renders out a pages that tells users that creation was complete.
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

  #Update finds the current bulletin id within the current parameter committing any updates on the bulletin on request showing a message on completion.
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

  #Finds the current bulletin id within the current parameter and assigns it to @bulletin, then calls destroy on that bulletin.
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


  #If the user is not signed in, or the current user does not own the bulletin, redirect them to notebooks page with an error,ensuring complete ownership of bulletins.
  def owns_bulletin
    if !user_signed_in? || current_user != Bulletin.find(params[:id]).user
      redirect_to notebooks_path(params[:notebook_id]), alert: 'You cannot do this as you do not own this bulletin'
    end
  end

  #If the user is not signed in, or the current user is not a tutor, redirect them to notebooks page with an error.
  def is_tutor
    if !user_signed_in? || current_user.tutor != true
      redirect_to notebook_path, alert: 'You must be a tutor to do this'
    end
  end

end
