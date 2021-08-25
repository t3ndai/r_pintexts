class SnippetSerializer
  include FastJsonapi::ObjectSerializer
  attributes :description, :url
  belongs_to :user
end
