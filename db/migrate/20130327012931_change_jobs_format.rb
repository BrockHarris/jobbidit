class ChangeJobsFormat < ActiveRecord::Migration
	def change
  	change_column :jobs, :title, :text
  	change_column :jobs, :description, :text
  	change_column :jobs, :category, :text
  end
end
