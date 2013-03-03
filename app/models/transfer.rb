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

class Transfer < Payment
  include Extensions::UUID
  
  attr_accessible :transfer_cash_id 
 		
  belongs_to	:dst_cash,
		:class_name	=> "Cash",
		:foreign_key	=> "transfer_cash_id"

  def name
    if self.category.come == false then
        "#{self.category.name} на счёт '#{self.dst_cash.name}'"
    else
	"#{self.category.name} со счёта '#{self.dst_cash.name}'"
    end
  end		
    
end
