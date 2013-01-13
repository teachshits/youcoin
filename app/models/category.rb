class Category < ActiveRecord::Base
  include Extensions::UUID
  attr_accessible :name, :ancestry
  has_many :payments
  

  has_ancestry

attr_accessor :skip_after_save


  after_save :update_ancestry

def update_ancestry
return false if self.skip_after_save
 parent = Category.find_by_uuid(self.ancestry)
 self.update_attribute(:ancestry , '#{parent.ancestry}/#{parent}' )
 self.skip_after_save = true
end

end
