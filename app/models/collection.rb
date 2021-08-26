class Collection < ApplicationRecord
  belongs_to :user
  validates :name, uniqueness: {scope: :user}, presence: true 
end
