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
       expect(json_response[:description]).to eq(snippet.description)
    end 
  end 
  
end
