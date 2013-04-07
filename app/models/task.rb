class Task < ActiveRecord::Base
  attr_accessible :datedue, :description, :name
  validates :datedue, :description, :name, :presence => true


  belongs_to :notebook
end
