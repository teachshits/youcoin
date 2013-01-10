class Payment < ActiveRecord::Base
  include Extensions::UUID
  attr_accessible :summa, :category_id
  belongs_to :category
end
