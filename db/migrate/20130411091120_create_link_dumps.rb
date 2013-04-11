class CreateLinkDumps < ActiveRecord::Migration
  def change
    create_table :link_dumps do |t|
      t.string :description
      t.integer :notebook_id
      t.integer :user_id

      t.timestamps
    end
  end
end
