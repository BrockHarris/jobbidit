class CreatePastworks < ActiveRecord::Migration
  def up
    create_table :pastworks do |t|
      t.integer    :user_id
      t.string     :title
      t.string     :content
      t.string     :photo_file_name
      t.string     :photo_file_type
      t.integer    :photo_file_size
      t.timestamps
    end
    add_index :pastworks, :user_id
  end

  def down
    drop_table :pastworks
  end
end
