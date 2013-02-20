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

require 'test_helper'

class PaymentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
