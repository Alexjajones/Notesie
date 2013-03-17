class Notebook < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :tasks,  dependent: :destroy
  belongs_to :user
end
