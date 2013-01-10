class Category < ActiveRecord::Base
  include Extensions::UUID
  attr_accessible :name, :category_id
  has_many :payments
end
