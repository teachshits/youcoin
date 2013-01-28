class Tag < ActiveRecord::Base
  include Extensions::UUID
  attr_accessible :name
  has_many :payments
end
