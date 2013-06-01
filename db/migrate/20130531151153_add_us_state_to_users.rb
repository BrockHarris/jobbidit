class AddUsStateToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :us_state, :string
  end
end
