class AddSubjectIdToNotebooks < ActiveRecord::Migration
  def change
    add_column :notebooks, :subject_id, :integer
  end
end
