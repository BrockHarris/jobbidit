class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string    :email
      t.string    :username
      t.string    :firstname
      t.string    :lastname
      t.string    :address
      t.string    :city
      t.string    :state
      t.string    :zip
      t.string    :phone      
      t.string    :password_hash
      t.string    :password_salt
      t.string    :reset_code, :limit=>50
      t.datetime  :reset_code_at
      t.string    :facebook_id
      t.string    :token
      t.string    :created_by 
      t.string    :state, :limit=>25
      t.string    :role, :limit=>25
      t.string    :activation_code, :limit=>100
      t.datetime  :activated_at
      t.datetime  :activation_email_sent_at
      t.boolean   :admin, :default=>false
      t.boolean   :verified, :default=>false
      t.string    :photo_file_name
      t.string    :photo_file_type
      t.integer   :photo_file_size
      t.timestamps
    end
    add_index :users, :email
    add_index :users, :username
  end

  def down
    drop_table :users
  end
end
