class SubjectsController < ApplicationController

  # Passes all of current subjects via the Subject model into the @subjects hash/array and displays the index view.
  # GET /subjects
  # GET /subjects.json
  def index
    @subjects = Subject.all

    respond_to do |format|
      format.html # index.html.erb.erb
      format.json { render json: @subjects }
    end
  end


  #Finds the current subject id within the current parameter, passes it into @subject hash/array and displays that single subject via the show view.
  # GET /subjects/1
  # GET /subjects/1.json
  def show
    @subject = Subject.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subject }
    end
  end

  #Calls .new to create a new subject via the Subject model and displays that single subject via the new.html.erb view.
  # GET /subjects/new
  # GET /subjects/new.json
  def new
    @subject = Subject.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @subject }
    end
  end

  #Finds the current subject id within the current parameter and displays that single subject with editing options via the edit.html.erb view, which renders the _form.html.erb as the form.
  # GET /subjects/1/edit
  def edit
    @subject = Subject.find(params[:id])
  end

  #Calls .new to create a new subject via the Subject model with a new id.
  # POST /subjects
  # POST /subjects.json
  def create
    @subject = Subject.new(params[:subject])

    respond_to do |format|
      if @subject.save
        format.html { redirect_to @subject, notice: 'Subject was successfully created.' }
        format.json { render json: @subject, status: :created, location: @subject }
      else
        format.html { render action: "new" }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  #Update finds the current subject id within the current parameter committing any updates on the subject on request showing a message on completion.
  # PUT /subjects/1
  # PUT /subjects/1.json
  def update
    @subject = Subject.find(params[:id])

    respond_to do |format|
      if @subject.update_attributes(params[:subject])
        format.html { redirect_to @subject, notice: 'Subject was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  #Finds the current subject id within the current parameter and assigns it to @subject, then calls destroy on that subject.
  # DELETE /subjects/1
  # DELETE /subjects/1.json
  def destroy
    @subject = Subject.find(params[:id])
    @subject.destroy

    respond_to do |format|
      format.html { redirect_to subjects_url }
      format.json { head :no_content }
    end
  end
end
