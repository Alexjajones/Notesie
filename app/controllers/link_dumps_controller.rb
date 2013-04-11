class LinkDumpsController < ApplicationController
  # GET /link_dumps
  # GET /link_dumps.json
  # Passes all of current links via the LinkDump model into the @link_dumps hash/array and displays the index view.
  def index
    @link_dumps = LinkDump.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @link_dumps }
    end
  end

  #Finds the current link id within the current parameter, passes it into @link_dump hash/array and displays that single link via the show view.
  #Also passes current notebook from the Notebooks model into @notebook hash/array
  # GET /link_dumps/1
  # GET /link_dumps/1.json
  def show
    @notebook = Notebook.find(params[:notebook_id])
    @link_dump = LinkDump.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @link_dump }
    end
  end

  #Calls .new to create a new link via the LinkDump model and displays that single link via the new.html.erb view.
  #Also passes current notebook from the Notebooks model into @notebook hash/array.
  # GET /link_dumps/new
  # GET /link_dumps/new.json
  def new
    @notebook = Notebook.find(params[:notebook_id])
    @link_dump = LinkDump.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @link_dump }
    end
  end

  #Finds the current link id within the current parameter and displays that single link with editing options via the edit.html.erb view, which renders the _form.html.erb as the form.
  # GET /link_dumps/1/edit
  def edit
    @link_dump = LinkDump.find(params[:id])
  end

  #Calls .new to create a new link nested under notebooks, passing the link via the parameter.
  #Also passes current notebook from the Notebooks model into @notebook hash/array.
  #Assigns the link's notebook_id field to the current notebooks id. Assigns the link's user_id field to the current users id.
  # POST /link_dumps
  # POST /link_dumps.json
  def create
    @notebook = Notebook.find(params[:notebook_id])
    @link_dump = LinkDump.new(params[:link_dump])
    @link_dump.notebook_id = @notebook.id
    @link_dump.user_id = current_user

    respond_to do |format|
      if @link_dump.save
        format.html { redirect_to notebook_path(@notebook), notice: 'Link dump was successfully created.' }
        format.json { render json: @link_dump, status: :created, location: @link_dump }
      else
        format.html { render action: "new" }
        format.json { render json: @link_dump.errors, status: :unprocessable_entity }
      end
    end
  end

  #Update finds the current link id within the current parameter committing any updates on the link on request showing a message on completion.
  #Redirects user to the tasks root /notebooks/:id
  # PUT /link_dumps/1
  # PUT /link_dumps/1.json
  def update
    @link_dump = LinkDump.find(params[:id])

    respond_to do |format|
      if @link_dump.update_attributes(params[:link_dump])
        format.html { redirect_to notebook_path(@notebook), notice: 'Link dump was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @link_dump.errors, status: :unprocessable_entity }
      end
    end
  end

  #Finds the current link id within the current parameter and assigns it to @link_dump, then calls destroy on that link.
  # DELETE /link_dumps/1
  # DELETE /link_dumps/1.json
  def destroy
    @link_dump = LinkDump.find(params[:id])
    @link_dump.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end
end
