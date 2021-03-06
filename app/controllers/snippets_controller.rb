class SnippetsController < ApplicationController
    before_action :set_snippet, only: [:show, :destroy]
    before_action :check_login, only: [:create]
    before_action :check_owner, only: [:destroy]

    def index 
        @snippets = Snippet.all 
        render json: SnippetSerializer.new(@snippets).serializable_hash
    end 

    def show 
        if @snippet
            options = { include: [:user] }
            render json: SnippetSerializer.new(@snippet, options).serializable_hash
        else 
            head :not_found 
        end 
    end

    def create 
        snippet = Snippet.new(snippet_params)
        snippet.user = current_user
        if snippet.save 
            render json: SnippetSerializer.new(snippet).serializable_hash, status: :created 
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
