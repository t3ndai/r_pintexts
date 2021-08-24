class Snippet < ApplicationRecord
    belongs_to :user
    validates :description, presence: true 

    private
      def snippet_params 
        params.require(:snippet).permit(:description, :url)
      end 
end
