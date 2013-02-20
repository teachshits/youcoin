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

require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
