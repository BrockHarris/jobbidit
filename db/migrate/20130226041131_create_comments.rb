class CreateComments < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.string    :user_id
      t.string    :job_id
      t.string    :content
      t.timestamps
    end
    add_index :comments, [:user_id, :job_id, :content]
  end

  def down
    drop_table :comments
  end
end
