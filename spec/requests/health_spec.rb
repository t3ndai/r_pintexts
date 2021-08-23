require 'rails_helper'
require 'json'

RSpec.describe 'Healths', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/health/index'

      body_hash = JSON.parse(response.body).deep_symbolize_keys

      expect(body_hash).to eq({ status: 'online' })

      expect(response).to have_http_status(:success)
    end
  end
end
