#encoding: utf-8
# == Schema Information
#
# Table name: categories
#
#  uuid           :string(36)       primary key
#  name           :string(255)      not null
#  ancestry       :string(255)
#  ancestry_depth :integer          default(0)
#  user_id        :integer
#  come           :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

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
