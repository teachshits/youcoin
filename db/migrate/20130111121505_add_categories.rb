#encoding: utf-8
class AddCategories < ActiveRecord::Migration
  def up
	Category.create!(:name => 'Личные расходы', :parent  => nil)
	
	b1 = Category.create!(:name => 'Транспорт', :parent  => nil)
	bb1 = Category.create!(:name => 'Общественный транспорт', :parent  => b1)
	bb2 = Category.create!(:name => 'Автомобиль', :parent  => b1)
	
	c1 = Category.create!(:name => 'Личные расходы', :parent  => nil)
	cc1 = Category.create!(:name => 'Здоровье', :parent  => c1)
	cc2 = Category.create!(:name => 'Обучение', :parent  => c1)
	
	d1 = Category.create!(:name => 'Семейные расходы', :parent  => nil)

  end

  def down
  	Category.delete_all
  end
end
