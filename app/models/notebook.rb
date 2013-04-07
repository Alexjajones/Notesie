class Notebook < ActiveRecord::Base
  attr_accessible :description, :name, :subject_id
  validates  :description, :name, :presence => true

  has_many :tasks,  dependent: :destroy

  belongs_to :user
  belongs_to :subject
end
