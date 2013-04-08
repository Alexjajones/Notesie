class Bulletin < ActiveRecord::Base
  attr_accessible :description, :title, :subject_id

  belongs_to :user
end
