class CollectionsController < ApplicationController
    before_action :set_collection, only: [:destroy]
    before_action :check_login, only: [:create]
    before_action :check_owner, only: [:destroy]
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
            head :not_found
        end 
    end 

    def create 
        collection = current_user.collections.build(collection_params)

        if collection.save 
            render json: CollectionsSerializer.new(collection).serializable_hash, status: :created 
        else 
            render json: {errors: collection.errors }, status: :bad_request
        end 
    end

    def destroy
        @collection.destroy 
        head :no_content
    end 


    private 
    def collection_params 
        params.require(:collection).permit(:name)
    end 

    def check_owner
        head :forbidden unless @collection.user_id == current_user&.id 
    end 
    
    def set_collection 
        @collection = Collection.find(params[:id])
    end 
end
