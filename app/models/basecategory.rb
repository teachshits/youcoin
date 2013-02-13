class Basecategory < ActiveRecord::Base
  include Extensions::UUID
  attr_accessible :name, :parent , :ancestry, :parent_id, :come
  
  has_ancestry :cache_depth => true

end
