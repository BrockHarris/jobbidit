class CreateBids < ActiveRecord::Migration
  def up
    create_table :bids do |t|
      t.integer    :user_id
      t.integer    :job_id
      t.integer    :amount
      t.timestamps
    end
    add_index :bids, [:user_id, :job_id, :amount]
  end

  def down
    drop_table :bids
  end
end
