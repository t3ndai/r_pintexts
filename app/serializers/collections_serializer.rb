class CollectionsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name 
  has_many :snippets  
end
