class AddNotebookIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :notebook_id, :integer
  end
end
