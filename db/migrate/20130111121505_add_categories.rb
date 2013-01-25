#encoding: utf-8
class AddCategories < ActiveRecord::Migration
  def up
	
	b1 = Basecategory.create!(:name => 'Транспорт', :parent  => nil)
	bb1 = Basecategory.create!(:name => 'Общественный транспорт', :parent  => b1)
	bb2 = Basecategory.create!(:name => 'Автомобиль', :parent  => b1)
	
	c1 = Basecategory.create!(:name => 'Личные расходы', :parent  => nil)
	cc1 = Basecategory.create!(:name => 'Здоровье', :parent  => c1)
	cc2 = Basecategory.create!(:name => 'Обучение', :parent  => c1)
	
	d1 = Basecategory.create!(:name => 'Семейные расходы', :parent  => nil)
	dd1 = Basecategory.create!(:name => 'Квартплата', :parent => d1)

  end

  def down
  	Basecategory.delete_all
  end
end
