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

  # GET /link_dumps/1/edit
  def edit
    @link_dump = LinkDump.find(params[:id])
  end

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

  # PUT /link_dumps/1
  # PUT /link_dumps/1.json
  def update
    @link_dump = LinkDump.find(params[:id])

    respond_to do |format|
      if @link_dump.update_attributes(params[:link_dump])
        format.html { redirect_to @link_dump, notice: 'Link dump was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @link_dump.errors, status: :unprocessable_entity }
      end
    end
  end

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
