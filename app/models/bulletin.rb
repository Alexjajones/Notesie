# == Schema Information
#
# Table name: bulletins
#
#  id          :integer          not null, primary key
#  title       :string(255)      not null
#  description :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  subject_id  :integer          not null
#  user_id     :integer          not null
#
#Creates table bulletins and adds validation to it.
#

class Bulletin < ActiveRecord::Base
  attr_accessible :description, :title, :subject_id
  validates  :description, :title, :subject_id, :presence => true

  belongs_to :user
end
