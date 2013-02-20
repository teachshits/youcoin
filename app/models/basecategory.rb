# == Schema Information
#
# Table name: basecategories
#
#  uuid           :string(36)       primary key
#  name           :string(255)      not null
#  ancestry       :string(255)
#  ancestry_depth :integer          default(0)
#  come           :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Basecategory < ActiveRecord::Base
  include Extensions::UUID
  attr_accessible :name, :parent , :ancestry, :parent_id, :come
  
  has_ancestry :cache_depth => true

end
