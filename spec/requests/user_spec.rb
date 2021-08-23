require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'POST /create' do
    example 'valid user attributes' do
      user = { username: 'aa', password: ('a' * 8).to_s,
               password_confirmation: ('a' * 8).to_s, email: 'aa@aa.com' }
      post '/users', params: { user: user }

      expect(response.status).to eq(201)

      user_response = JSON.parse(response.body).deep_symbolize_keys
      expect(user_response).to include(:id, :username)
    end

    example 'invalid user attributes' do
      user = { username: 'aa', password: ('a' * 8).to_s, password_confirmation: ('a' * 8).to_s }

      post '/users', params: { user: user }

      expect(response).to have_http_status(:bad_request)
    end
  end

  describe 'PATCH /update' do
    describe 'can update user' do
      before do
        @user = User.create(username: 'aa', password: ('a' * 8).to_s, password_confirmation: ('a' * 8).to_s,
                            email: 'aa@aa.com')
      end

      example 'update username' do
        @user.username = 'ab'
        patch '/users/' + @user.id.to_s, params: { user: { username: @user.username } }, headers: {
          Authorization: JsonWebToken.encode(user_id: @user.id)
        }
        expect(response).to have_http_status(:success)

        user_response = JSON.parse(response.body).deep_symbolize_keys

        expect(user_response[:username]).to eq('ab')
      end

      example 'should forbid update without autorization' do
        @user.username = 'ab'
        patch '/users/' + @user.id.to_s, params: { user: { username: @user.username } }

        expect(response).to have_http_status(:forbidden)
      end

      def patch_request(username)
        { user: { username: username } }
      end

      def auth_headers(user_id)
        {
          Authorization: JsonWebToken.encode(user_id: user_id)
        }
      end
    end
  end
end
