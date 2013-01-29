#encoding: utf-8
class Payment < ActiveRecord::Base
  include Extensions::UUID
  attr_accessible :summa, :category_id, :cash_id, :tag_ids
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

  before_save :change_balance
  
  private
  def change_balance
    self.cash.balance = self.cash.balance - self.summa
    self.cash.save!
  end
  
end
