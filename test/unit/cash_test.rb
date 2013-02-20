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

require 'test_helper'

class CashTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
