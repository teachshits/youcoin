#encoding: utf-8
class Category < ActiveRecord::Base
  include Extensions::UUID
  attr_accessible :name, :parent, :ancestry, :ancestry_depth, :parent_id, :come
  has_many :payments
  has_ancestry :cache_depth => true
  belongs_to :user
  
  HUMAN_ATTRIBUTE_NAMES = {
    :name => 'Имя',
    :parent => 'Родитель',
    :user => 'Пользователь'
  }
  class << self
    def human_attribute_name attribute_name
	HUMAN_ATTRIBUTE_NAMES[attribute_name.to_sym] || super
    end
  end


end
