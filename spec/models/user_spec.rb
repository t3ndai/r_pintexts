require 'rails_helper'

RSpec.describe User, type: :model do
  
  context "using user subject" do 
    subject { described_class.new(password: 'aaaabbbb', password_confirmation: 'aaaabbbb', email: 'user@example.com', username: 'aa') }
    

    it "should be valid" do 
      is_expected.to be_valid
    end 

    it "is not valid without an email" do 
      subject.email = ""
      expect(subject).not_to be_valid
    end 

    it "is not valid without a username" do 
      subject.username = ""
      expect(subject).not_to be_valid
    end 

    it "is not valid without a password" do 
      subject.password = subject.password_confirmation = " " * 8 
      expect(subject).not_to be_valid
    end 

    context 'unique' do 
      before { described_class.create(password: 'aaaabbbb', password_confirmation: 'aaaabbbb', email: 'user@example.com', username: 'aa')}

      it "is not valid without a unique email" do 
        expect(subject).not_to be_valid
      end 

      it "is not valid without a unique username" do 
        expect(subject).not_to be_valid
      end 
    end 

    it "is not valid without a password less than 8 char" do 
      subject.password = subject.password_confirmation = 'aaaaa'
      expect(subject).not_to be_valid
    end 

  end 

end
