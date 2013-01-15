class Cash < ActiveRecord::Base
  include Extensions::UUID
  attr_accessible :name, :payments
  has_many :payments, :dependent => :destroy
  #accepts_nested_attributes_for :payments, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
  
end
