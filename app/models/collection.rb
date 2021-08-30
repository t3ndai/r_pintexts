class Collection < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :snippets
  validates :name, uniqueness: {scope: :user}, presence: true 
end
