class Category < ActiveRecord::Base
  include Extensions::UUID
  attr_accessible :name, :parent, :ancestry, :ancestry_depth, :parent_id
  has_many :payments
  has_ancestry :cache_depth => true
  belongs_to :user

end
