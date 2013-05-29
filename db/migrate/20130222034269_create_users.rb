class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string    :email
      t.string    :username
      t.string    :firstname
      t.string    :lastname
      t.string    :displayname
      t.string    :address
      t.string    :city
      t.string    :state
      t.string    :zip
      t.string    :phone
      t.string    :timezone
      t.string    :membership  
      t.string    :contractor_type 
      t.string    :about_title 
      t.string    :about_content
      t.string    :credentials
      t.string    :website
      t.string    :facebook
      t.string    :twitter
      t.string    :instant_message
      t.string    :password_hash
      t.string    :password_salt
      t.string    :reset_code, :limit=>50
      t.datetime  :reset_code_at
      t.datetime  :deleted_at
      t.string    :facebook_id
      t.string    :token
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
