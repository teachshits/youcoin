class Cash < ActiveRecord::Base
  include Extensions::UUID
  attr_accessible :name, :payments, :payments_attributes
  has_many :payments, :dependent => :destroy
  belongs_to :user
end
