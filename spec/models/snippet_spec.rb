require 'rails_helper'

RSpec.describe Snippet, type: :model do
  before do 
    @user = User.create(email: 'aa@aa.com', username: 'aa', password: ('a'*8).to_s, password_confirmation: ('a'*8).to_s)
  end

  subject { described_class.new(description: 'some saved text',
                        url: 'blog@random.com',
                        user_id: @user.id
                      )
  }  

  describe "Validations" do
    example "Snippet is valid with valid attributes" do 
      expect(subject).to be_valid
    end 

    it { should validate_presence_of(:description) }
  end 

  describe "Associations" do 
    it { should belong_to(:user) }
  end 

  example "Snippet should create a job to download url"
  
end
