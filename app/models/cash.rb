#encoding: utf-8
# == Schema Information
#
# Table name: cashes
#
#  uuid       :string(36)       primary key
#  name       :string(255)      not null
#  balance    :decimal(, )      not null
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Cash < ActiveRecord::Base
  include Extensions::UUID
  attr_accessible :name, :payments, :payments_attributes, :balance
  has_many :payments, :dependent => :destroy
  belongs_to :user
  
  belongs_to 	:transfers_out,
		:class_name	=> "Transfer",
		:foreign_key	=> "src_cash_id"
		
  belongs_to	:transfer_in,
		:class_name	=> "Transfer",
		:foreign_key	=> "dst_cash_id"
  
  default_scope { where(:user_id => User.current_user.id) }
  
  HUMAN_ATTRIBUTE_NAMES = {
    :name => 'Имя',
    :balance => 'Баланс',
    :payments => 'Платежи'
  }
  class << self
    def human_attribute_name attribute_name
	HUMAN_ATTRIBUTE_NAMES[attribute_name.to_sym] || super
    end
  end
  
  validates :name, :presence => true
  validates :balance, :presence => true
  validates :user, :presence => true

  def create_transfer(dst_cash, summa)
     transfer = Transfer.new
     transfer.cash = self
     transfer.dst_cash = dst_cash
     transfer.summa = summa.to_f 
     transfer.category = Category.where("name = ? and come = ?", 'Перевод', false).first
     transfer.save
     
     transfer = Transfer.new
     transfer.cash = dst_cash
     transfer.dst_cash = self
     transfer.summa = summa.to_f
     transfer.category = Category.where("name = ? and come = ?", 'Перевод', true).first
     transfer.save
  end
  
  def change_balance(new_balance)
	
	return if self.balance == new_balance
	
	delta = self.balance - new_balance

        payment = Payment.new
        payment.cash = self
        payment.category = Category.find(:all, :conditions=>["name = ? and come = ?", 'Изменение остатка', (delta < 0)]).first
        if (delta < 0) then
    	    payment.summa = -delta
        else
            payment.summa = delta
        end
        
        
        payment.save
  end
  
  before_create :record_user
  
  def record_user
    self.user = User.current_user
  end

end
