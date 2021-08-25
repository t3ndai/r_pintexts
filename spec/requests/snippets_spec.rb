require 'rails_helper'

RSpec.describe "Snippets", type: :request do

  let(:user) {
    User.create(username: 'aa', email: 'aa@aa.com', password: ('a'*8).to_s, password_confirmation: ('a'*8).to_s)
  }

  let(:snippet) {
    Snippet.create(description: 'some saved text', url: 'example.com/blog/1', user_id: user.id)
  }

  describe "GET /index" do
    example "should get all snippets" do 
      get '/snippets/'
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do 
    example "should get a single snippet" do 
       get "/snippets/#{snippet.id}"
       expect(response).to have_http_status(:success)

       json_response = JSON.parse(response.body).deep_symbolize_keys
       expect(json_response[:data][:attributes][:description]).to eq(snippet.description)
       expect(json_response[:data][:relationships][:user][:data][:id]).to eq(snippet.user_id.to_s)
       expect(json_response[:included][0][:attributes][:username]).to eq(snippet.user.username)
    end 
  end 

  describe "POST /create" do 
    example "should create snippet for logged in user" do 
      post '/snippets/', params: { snippet: {description: snippet.description, url: snippet.url} }, headers: {Authorization: JsonWebToken.encode(user_id: snippet.user_id)}
      expect(response).to have_http_status(:created)
    end 

    example "should forbid create snippet without logged in user" do 
      post "/snippets/", params: {snippet: snippet}
      expect(response).to have_http_status(:forbidden)
    end 
  end 

  describe "DELETE /destroy" do 
    example "should delete a product for a user" do 
      delete "/snippets/#{snippet.id}", headers: {Authorization: JsonWebToken.encode(user_id: snippet.user_id)}
      expect(response).to have_http_status(:no_content)
    end

    example "should forbid non snippet owner to destroy product" do 
      user_2 = User.create(username: 'bb', email: 'bb@bb.com', password: ('b'*8).to_s, password_confirmation: ('b'*8).to_s)
      delete "/snippets/#{snippet.id}", headers: {Authorization: JsonWebToken.encode(user_id: user_2.id)}
      expect(response).to have_http_status(:forbidden)
    end 
  end  
end
