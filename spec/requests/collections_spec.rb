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
end
