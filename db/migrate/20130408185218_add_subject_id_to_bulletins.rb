class AddSubjectIdToBulletins < ActiveRecord::Migration
  def change
    add_column :bulletins, :subject_id, :integer
  end
end
