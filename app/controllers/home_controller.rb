class HomeController < ApplicationController
#This formats and displays the home page allowing embedded ruby to be used. Without, only standard HTML could be used
  def index

    respond_to do |format|
      format.html # index.html.erb.erb
    end
  end

end
