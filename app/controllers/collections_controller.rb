class CollectionsController < ApplicationController
    def index 
        @collections = Collection.all 
        render json: CollectionsSerializer.new(@collections).serializable_hash
    end 

    def show
        collection = Collection.find(params[:id])
        if collection
            options = { include: [:snippets ]}
            render json: CollectionsSerializer.new(collection, options).serializable_hash
        else 
            head 404 
        end 
    end 
end
