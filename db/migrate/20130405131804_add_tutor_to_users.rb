class AddTutorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :tutor, :boolean
  end
end
