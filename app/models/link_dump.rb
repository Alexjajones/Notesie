class LinkDump < ActiveRecord::Base
  attr_accessible :description, :notebook_id, :user_id

  belongs_to :notebook
end
