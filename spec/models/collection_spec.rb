require 'rails_helper'

RSpec.describe Collection, type: :model do
  before do 
    @user = User.new(username: 'aa', email: 'aa@aa.com', password: ('a'*8).to_s, password_confirmation: ('a'*8).to_s)
  end
  
  subject {
    described_class.new(name: 'my col', user_id: @user.id)
  }

  describe "Validations" do 
    it { should validate_presence_of(:name) }

    example "user should only have unique collection" do 
      second_collection = Collection.new(name: 'my col', user_id: @user.id)
      expect(second_collection).not_to be_valid
    end 
  end 

  describe "Associations" do 
    it { should belong_to(:user) }
  end 
end
