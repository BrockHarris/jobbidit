class AddCredentialsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :credentials, :string
  	add_column :users, :website, :string
  	add_column :users, :facebook, :string
  	add_column :users, :twitter, :string
  	add_column :users, :instant_message, :string
  end
end
