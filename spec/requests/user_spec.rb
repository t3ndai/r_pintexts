require 'rails_helper'
require 'json'

RSpec.describe "Users", type: :request do

  describe "POST /create" do 
    example "valid user attributes" do 
      user = {username: 'aa', password: "#{'a'*8}", password_confirmation: "#{'a'*8}", email: 'aa@aa.com'}
      post "/users", params: {user: user } 
      
      expect(response.status).to eq(201)

      user_response = JSON.parse(response.body).deep_symbolize_keys 
      expect(user_response).to include(:id, :username)
    end

    example "invalid user attributes" do 
      user = {username: 'aa', password: "#{'a'*8}", password_confirmation: "#{'a'*8}" }

      post "/users", params: {user: user }

      expect(response).to have_http_status(:bad_request)
    end

  end

  describe "PATCH /update" do 
    describe "can update user" do 
      before { @user = User.create(username: 'aa', password: "#{'a'*8}", password_confirmation: "#{'a'*8}", email: 'aa@aa.com') }

      example 'update username' do 
        @user.username = 'ab'
        patch  '/users/'+ "#{@user.id}", params: {user: {username: @user.username}}  
        
        expect(response).to have_http_status(:success)

        user_response = JSON.parse(response.body).deep_symbolize_keys
        expect(user_response[:username]).to eq('ab')
      end

    end   

  end 

end
