class AddCategories < ActiveRecord::Migration
  def up
    base = 	Category.create!(:name => 'base', :parent  => nil)
  	Category.create!(:name => '1', :parent  => base)
  	Category.create!(:name => '2', :parent  => base)
  	Category.create!(:name => '3', :parent  => base)
  	d=Category.create!(:name => '4', :parent  => base)
    Category.create!(:name => '4d', :parent  => d)

  end

  def down
  	Category.delete_all
  end
end
