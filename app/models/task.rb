# == Schema Information
#
# Table name: tasks
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  description :text             not null
#  datedue     :datetime         not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  notebook_id :integer          not null
#

class Task < ActiveRecord::Base
  attr_accessible :datedue, :description, :name
  validates :datedue, :description, :name, :presence => true


  belongs_to :notebook
end
