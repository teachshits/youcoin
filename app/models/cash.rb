#encoding: utf-8
class Cash < ActiveRecord::Base
  include Extensions::UUID
  attr_accessible :name, :payments, :payments_attributes
  has_many :payments, :dependent => :destroy
  belongs_to :user
  
  HUMAN_ATTRIBUTE_NAMES = {
    :name => 'Имя',
    :payments => 'Платежи'
  }
  class << self
    def human_attribute_name attribute_name
	HUMAN_ATTRIBUTE_NAMES[attribute_name.to_sym] || super
    end
  end

end
