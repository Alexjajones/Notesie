class AddNotebookIdToTasks < ActiveRecord::Migration
  def change
    add_column :notebooks, :subject_id, :integer
  end

  def down
    remove_column :notebooks, :subject_id, :integer
  end
end
