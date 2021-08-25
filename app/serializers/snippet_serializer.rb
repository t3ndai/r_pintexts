class SnippetSerializer
  include FastJsonapi::ObjectSerializer
  attributes :description, :url
end
