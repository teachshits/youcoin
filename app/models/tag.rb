#encoding: utf-8
# == Schema Information
#
# Table name: tags
#
#  uuid       :string(36)       primary key
#  name       :string(255)      not null
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ActiveRecord::Base
  include Extensions::UUID
  attr_accessible :name, :payment_ids
  has_and_belongs_to_many :payments
  
  before_create :set_current_user
  
  def set_current_user
    self.user_id = User.current_user.id
  end
  
 default_scope { where(:user_id => User.current_user.id) }
 
   HUMAN_ATTRIBUTE_NAMES = {
    :name => 'Имя',
    :payment_ids => 'Платежи',
    :payments => 'Платежи'
  }
  class << self
    def human_attribute_name attribute_name
	HUMAN_ATTRIBUTE_NAMES[attribute_name.to_sym] || super
    end
  end

  
end
