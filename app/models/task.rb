class Task < ActiveRecord::Base
  attr_accessible :datedue, :description, :name

  belongs_to :notebook
end
