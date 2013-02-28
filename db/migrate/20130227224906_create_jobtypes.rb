class CreateJobtypes < ActiveRecord::Migration
  def up
    create_table :jobtypes do |t|
      t.string    :name
      t.timestamps
    end
    add_index :jobtypes, [:name]
  end

  def down
    drop_table :jobtypes
  end
end
