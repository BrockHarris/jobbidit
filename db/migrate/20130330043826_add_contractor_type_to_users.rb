class AddContractorTypeToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :contractor_type, :string
  end
end
