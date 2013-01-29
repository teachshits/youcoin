class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories, :id => false do |t|
      t.string :uuid, :limit => 36, :primary => true
      t.string :name, :null => false
      t.string :ancestry
      t.integer :ancestry_depth, :default => 0
      t.references :user
      t.timestamps
    end
    
    add_index :categories, [:ancestry]
  end
end
