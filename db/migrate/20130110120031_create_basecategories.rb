class CreateBasecategories < ActiveRecord::Migration
  def change
    create_table :basecategories, :id => false do |t|
      t.string :uuid, :limit => 36, :primary => true
      t.string :name, :null => false
      t.string :ancestry
      t.integer :ancestry_depth, :default => 0
      t.timestamps
    end
  end
end
