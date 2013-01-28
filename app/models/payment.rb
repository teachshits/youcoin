class Payment < ActiveRecord::Base
  include Extensions::UUID
  attr_accessible :summa, :category_id, :cash_id
  belongs_to :category
  belongs_to :cash
  has_many :tags
end
