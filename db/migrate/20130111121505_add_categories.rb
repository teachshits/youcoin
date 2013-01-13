class AddCategories < ActiveRecord::Migration
  def up
    base = 	Category.create!(:name => 'base', :ancestry => '0')
  	Category.create!(:name => '1', :ancestry => base)
  	Category.create!(:name => '2', :ancestry => base)
  	Category.create!(:name => '3', :ancestry => base)
  	Category.create!(:name => '4', :ancestry => base)

  end

  def down
  	Category.delete_all
  end
end
