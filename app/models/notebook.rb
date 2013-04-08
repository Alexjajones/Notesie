# == Schema Information
#
# Table name: notebooks
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  subject_id  :integer
#

class Notebook < ActiveRecord::Base
  attr_accessible :description, :name, :subject_id
  validates  :description, :name, :presence => true

  has_many :tasks,  dependent: :destroy
  has_many :bulletins

  belongs_to :user
  belongs_to :subject

end
