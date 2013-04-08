# == Schema Information
#
# Table name: bulletins
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  subject_id  :integer
#  user_id     :integer
#
#Creates table bulletins and adds vailidation to it.
#

class Bulletin < ActiveRecord::Base
  attr_accessible :description, :title, :subject_id

  belongs_to :user
end
