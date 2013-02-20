#encoding: utf-8
# == Schema Information
#
# Table name: payments
#
#  summa            :decimal(11, 2)   not null
#  uuid             :string(36)       primary key
#  category_id      :string(255)      not null
#  cash_id          :string(255)      not null
#  description      :text
#  transfer_cash_id :string(255)
#  type             :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Payment < ActiveRecord::Base
  include Extensions::UUID
  attr_accessible :summa, :tag_ids, :cash, :category
  belongs_to :category
  belongs_to :cash
  has_and_belongs_to_many :tags
  
  HUMAN_ATTRIBUTE_NAMES = {
    :summa => 'Сумма',
    :category => 'Категория',
    :cash => 'Кошелек',
    :tags => 'Тэги'
  }
  class << self
    def human_attribute_name attribute_name
	HUMAN_ATTRIBUTE_NAMES[attribute_name.to_sym] || super
    end
  end
  
  default_scope order("created_at DESC")
  
  def name
    "#{self.category.name}"
  end
  
  validates :summa, :presence => true
  validates :cash, :presence => true
  validates :category, :presence => true

  before_save :change_balance
  
  private
  def change_balance
  
    come = 1
    come = -1 if (self.category.come == true)
    
    Rails.logger.debug("Payment change balance")
    Rails.logger.debug("come=1") if come == 1
    Rails.logger.debug("come=-1") if come == -1 
  
    if (self.new_record?) then
	self.cash.balance = self.cash.balance - (self.summa*come)
	Rails.logger.debug("new_record")
	Rails.logger.debug(self.cash.balance)
	self.cash.save!
    else    
        payment = Payment.find(self.id)
        Rails.logger.debug("not new record")
        Rails.logger.debug(payment.summa)
        Rails.logger.debug(self.summa)
	if (payment.summa != self.summa) then
    	    self.cash.balance = self.cash.balance + (payment.summa - (self.summa*come))
    	    Rails.logger.debug(self.cash.balance)
    	    self.cash.save!
	end
    end
  end
  
end
