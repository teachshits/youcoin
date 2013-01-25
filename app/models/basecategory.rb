class Basecategory < ActiveRecord::Base
  include Extensions::UUID
  attr_accessible :name, :parent , :ancestry, :parent_id
  

  has_ancestry :cache_depth => true
  #:primary_key_format =>'([a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12})'



end
