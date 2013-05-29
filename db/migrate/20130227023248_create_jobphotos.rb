class CreateJobphotos < ActiveRecord::Migration
  def change
    create_table :jobphotos do |t|
    	t.integer :job_id
      t.string  :caption
      t.string  :photo_file_name
      t.string  :photo_file_type
      t.integer :photo_file_size
      t.timestamps
    end
    add_index :jobphotos, [:job_id]
  end
end
