#encoding: utf-8
class CreateBasecategories < ActiveRecord::Migration
  def change
    create_table :basecategories, :id => false do |t|
      t.string :uuid, :limit => 36, :primary => true
      t.string :name, :null => false
      t.string :ancestry
      t.integer :ancestry_depth, :default => 0
      
      # come - поле, направление перевода
      # true - Расход - Положить на счёт
      # false - Доход - Изьять со счёта
      t.boolean	:come, :default => false
      
      t.timestamps
    end
  end
end
