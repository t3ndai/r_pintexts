require 'rails_helper'

RSpec.describe "Collections", type: :request do
  before do
    @user = User.create(username: 'aa', email: 'aa@aa.com', password: ('a'*8).to_s, password_confirmation: ('a'*8).to_s) 
    @collection = Collection.create(name: 'default', user_id: @user.id)
    @snippet = Snippet.create(description: 'some saved text', url: 'example.com/blog/1', user_id: @user.id)
  end 

  describe "GET /index" do
    example "should get all public collections" do 
      get '/collections/'
      expect(response).to have_http_status(:success)
    end 
  end

  describe "GET /show" do
    example "should get a public single collection" do 
      @collection.snippets << @snippet
      get "/collections/#{@collection.id}"

      expect(response).to have_http_status(:success)
      response_json = JSON.parse(response.body, symbolize_names: true)
      expect(@user.snippets.first.description).to eq(response_json.dig(:included, 0, :attributes, :description))

    end 
  end 

  describe "POST /create" do 
    example "should forbid create collection for unlogged user" do 
      post "/collections/", params: { collection: {name: @collection.name }}
      expect(response).to have_http_status(:forbidden)
    end 

    example "should create collection for logged in user" do 
      other_collection = Collection.new(name: 'my saved stuff', user_id: @user.id)
      post "/collections/", params: { collection: {name: other_collection.name } }, headers: { Authorization: JsonWebToken.encode(user_id: other_collection.user_id)}
      expect(response).to have_http_status(:created)
    end 
  end 

  describe "DELETE /destroy" do 
    example "should delete a collection for a user" do 
      delete "/collections/#{@collection.id}", headers: {Authorization: JsonWebToken.encode(user_id: @collection.user_id)}
      expect(response).to have_http_status(:no_content)
    end
    
    example "should forbid non collection owner to destroy collection" do 
      user_2 = User.create(username: 'bb', email: 'bb@bb.com', password: ('b'*8).to_s, password_confirmation: ('b'*8).to_s)
      delete "/collections/#{@collection.id}", headers: {Authorization: JsonWebToken.encode(user_id: user_2.id)}
      expect(response).to have_http_status(:forbidden)
    end 
  end

  describe "POST /snippet" do 
    example "should save snippet to collection for user" do 
      post "/collections/#{@collection.id}/snippet", params: {collection: {snippet: {snippet_id: @snippet.id } } }, headers: {Authorization: JsonWebToken.encode(user_id: @collection.user_id)}

      expect(response).to have_http_status(:created)

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(@user.snippets.first.id.to_s).to eq(json_response.dig(:data, :relationships, :snippets, :data, 0, :id))
    end
    
    example "should forbid non logged in user to save a snippet to collection" do 
      post "/collections/#{@collection.id}/snippet", params: {collection: {snippet: {snippet_id: @snippet.id} } }

      expect(response).to have_http_status(:forbidden)
    end 
  end 

  describe "DELETE /:collection/:snippet" do 
    example "should remove snippet from collection for logged in user" do 
      delete "/collections/#{@collection.id}/#{@snippet.id}", headers: {Authorization: JsonWebToken.encode(user_id: @collection.user_id)}
      expect(response).to have_http_status(:no_content)
    end
    
    example "should forbid non owner from removing snippet in collection" do 
      user_2 = User.create(username: 'bb', email: 'bb@bb.com', password: ('b'*8).to_s, password_confirmation: ('b'*8).to_s)
      delete "/collections/#{@collection.id}/#{@snippet.id}", headers: {Authorization: JsonWebToken.encode(user_id: user_2.id)}
      expect(response).to have_http_status(:forbidden)
    end 
  end 
end
