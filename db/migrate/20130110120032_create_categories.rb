#encoding: utf-8
class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories, :id => false do |t|
      t.string :uuid, :limit => 36, :primary => true
      t.string :name, :null => false
      t.string :ancestry
      t.integer :ancestry_depth, :default => 0
      t.integer :user_id, :default => nil
      
      # come - поле, направление перевода
      # true - Расход - Положить на счёт
      # false - Доход - Изьять со счёта
      t.boolean	:come, :default => false
      
      t.timestamps
    end
    
    add_index :categories, [:ancestry]
  end
end
