class SnippetsController < ApplicationController

    def index 
        render json: Snippet.all
    end 

    def show 
        @snippet = Snippet.find(params[:id])
        render json: @snippet
    end 
end
