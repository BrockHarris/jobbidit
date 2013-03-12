class CreatePmessages < ActiveRecord::Migration
def up
    create_table :pmessages do |t|
      t.integer   :user_id
      t.integer   :receiver_id
      t.string    :title
      t.string    :body
      t.datetime  :deleted_at
      t.boolean   :read, :default=>false
      t.timestamps
    end
    add_index :pmessages, [:user_id, :receiver_id]
  end

  def down
    drop_table :pmessages
  end
end