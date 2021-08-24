class SnippetsController < ApplicationController
    before_action :set_snippet, only: [:show, :destroy]
    before_action :check_login, only: [:create]
    before_action :check_owner, only: [:destroy]

    def index 
        render json: Snippet.all
    end 

    def show 
        render json: @snippet
    end

    def create 
        snippet = Snippet.new(snippet_params)
        snippet.user = current_user
        if snippet.save 
            render json: snippet, status: :created 
        else 
            render json: {errors: snippet.errors}, status: :bad_request
        end 
    end 

    def destroy 
        @snippet.destroy
        head :no_content
    end 

    private 
    def snippet_params
        params.require(:snippet).permit(:description, :url)
    end 

    def check_owner
        head :forbidden unless @snippet.user_id == current_user&.id 
    end 

    def set_snippet
        @snippet = Snippet.find(params[:id])
    end 
end
