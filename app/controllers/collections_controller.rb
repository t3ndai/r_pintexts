class CollectionsController < ApplicationController
    def index 
        @collections = Collection.all 
        render json: CollectionsSerializer.new(@collections).serializable_hash
    end 
end
