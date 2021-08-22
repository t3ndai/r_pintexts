require 'rails_helper'

RSpec.describe 'Tokens', type: :request do
  describe 'POST /create' do
    before do
      @user = User.create(username: 'aa', password: ('a' * 8).to_s, password_confirmation: ('a' * 8).to_s,
                          email: 'aa@aa.com')
    end

    example 'login with correct details, should return token' do
      post '/tokens/', params: { user: { email: @user.email, password: @user.password } }

      token_response_json = JSON.parse(response.body).deep_symbolize_keys

      expect(response).to have_http_status(:success)
      expect(token_response_json).to include(:token)
    end

    example 'attempt to login with wrong details, should not return token' do
      post '/tokens/', params: { user: { email: @user.email, password: ('b' * 8).to_s } }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
