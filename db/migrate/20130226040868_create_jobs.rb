class CreateJobs < ActiveRecord::Migration
  def up
    create_table :jobs do |t|
      t.integer   :user_id
      t.string    :title
      t.string    :description
      t.string    :category
      t.integer   :current_bid
      t.integer   :duration
      t.datetime  :expire_date
      t.boolean   :open, :default=>true
      t.timestamps
    end
    add_index :jobs, [:user_id, :category, :expire_date]
  end

  def down
    drop_table :jobs
  end
end