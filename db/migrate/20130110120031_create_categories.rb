class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories, :id => false do |t|
      t.string :uuid, :limit => 36, :primary => true
      t.string :name, :null => false
      t.belongs_to :category_parent

      t.timestamps
    end
  end
end
