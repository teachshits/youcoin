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
        "#{self.category.name} на счёт #{self.dst_cash.name}"
    else
	"#{self.category.name} со счёта #{self.dst_cash.name}"
    end
  end		
  
  after_save :create_transfer
  
  private
  
  def create_transfer
  
    log = Rails.logger
    log.debug("create_trancsfer")
  
    transfer = Transfer.new
    transfer.cash = self.dst_cash
    transfer.dst_cash = self.cash
    transfer.summa = self.summa.to_i * (-1)
    transfer.category = Category.where("name = ? and come = ?", 'Перевод', !(self.category.come)).first

    Transfer.skip_callback(:save, :after, :create_transfer)    
    transfer.save
    Transfer.set_callback(:save, :after, :create_transfer)
#    Transfer.skip_callback(:after)
#     transfer.send(:create_without_callbacks)
#    Transfer.set_callback(:after)
  
#    cash_src = Cash.find(transfer.transfer_cash_id)
#    transfer_src = Transfer.new
#    transfer_src.transfer_cash_id = @cash
#    transfer_src.category = Category.where("name = ? and come = ?", 'Перевод', !come_).first
#    transfer_src.cash = cash_src
#    transfer_src.summa = params[:summa].to_i * (-1)
#    transfer_src.save!

  
  end
		
end
