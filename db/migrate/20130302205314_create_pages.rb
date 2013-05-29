class CreatePages < ActiveRecord::Migration
  def up
    create_table :pages do |t|
      t.string   :name
      t.text     :header 
      t.text     :content 
      t.timestamps
    end
    add_index :pages, [:name]
  end

  def down
    drop_table :pages
  end
end
