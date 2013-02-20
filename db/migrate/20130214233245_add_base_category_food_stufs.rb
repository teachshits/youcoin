#encoding: utf-8
class AddBaseCategoryFoodStufs < ActiveRecord::Migration
  def up
    	b1 = Basecategory.create!(:name => 'Питание', :parent  => nil)
	bb1 = Basecategory.create!(:name => 'Продукты питания', :parent  => b1)
	bb2 = Basecategory.create!(:name => 'Ресторан/Кофе', :parent  => b1)
  end

  def down
    Basecategory.delete_all(:name => 'Ресторан/Кофе')
    Basecategory.delete_all(:name => 'Продукты питания')
    Basecategory.delete_all(:name => 'Питание')
  end
end
