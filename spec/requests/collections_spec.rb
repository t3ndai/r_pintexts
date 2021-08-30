require 'rails_helper'

RSpec.describe "Collections", type: :request do
  before do
    @user = User.new(username: 'aa', email: 'aa@aa.com', password: ('a'*8).to_s, password_confirmation: ('a'*8).to_s) 
    @collection = Collection.new(name: 'default', user_id: @user.id)
  end 

  describe "GET /index" do
    example "should get all public collections" do 
      get '/collections/'
      expect(response).to have_http_status(:success)
    end 

  end
end
