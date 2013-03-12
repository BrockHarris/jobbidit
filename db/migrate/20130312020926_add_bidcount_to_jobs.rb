class AddBidcountToJobs < ActiveRecord::Migration
  def change
  	add_column :jobs, :bid_count, :integer
  end
end
