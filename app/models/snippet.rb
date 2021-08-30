class Snippet < ApplicationRecord
    belongs_to :user
    has_and_belongs_to_many :collections
    validates :description, presence: true 

    private
      def snippet_params 
        params.require(:snippet).permit(:description, :url)
      end 
end
