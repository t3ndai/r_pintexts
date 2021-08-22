require 'rails_helper'

RSpec.describe Authenticable do
  before do
    @user = User.create(username: 'aa', password: ('a' * 8).to_s, password_confirmation: ('a' * 8).to_s,
                        email: 'aa@aa.com')
    @authentication = MockController.new
  end

  example 'should get user from Authorization token' do
    @authentication.request.headers['Authorization'] = JsonWebToken.encode(user_id: @user.id)

    expect(@user.id).to eq(@authentication.current_user.id)
  end

  example 'should not get user from empty Authorization token' do
    @authentication.request.headers['Authorization'] = nil

    expect(@authentication.current_user).to be_nil
  end
end

class MockController
  include Authenticable
  attr_accessor :request

  def initialize 
    mock_request = Struct.new(:headers)
    self.request = mock_request.new({})
  end 
end
