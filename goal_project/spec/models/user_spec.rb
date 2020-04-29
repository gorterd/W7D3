require 'rails_helper'

RSpec.describe User, type:  :model do 

    subject(:user) do 
        FactoryBot.create(:user) 
    end

    describe "validations" do
        it {should validate_presence_of :username}
        it {should validate_presence_of :password_digest}
        it {should validate_presence_of :session_token}
        it {should validate_length_of(:password).is_at_least(5)}



        it {should validate_uniqueness_of :session_token}
        it {should validate_uniqueness_of :username}
    end

    describe "::find_by_credentials" do
        it "return user that matches credentials" do
            expect(User.find_by_credentials(user.username, 'password')).to eq(user)
        end

        it "should return nil if no match found" do
            expect(User.find_by_credentials(user.username, 'fake_password')).to eq nil
        end
    end

    describe "#is_password?" do 

        it "verifies the correct password" do
            expect(user.is_password?("password")).to be true
        end

        it "verifies an incorrect password" do
            expect(user.is_password?("fake_password")).to be false
        end

    end

    describe "#reset_session_token!" do

        it "sets a new session token" do
            old_token = user.session_token
            user.reset_session_token!
            expect(user.session_token).not_to eq(old_token)
        end

        it "saves user to the database" do
            new_token = user.reset_session_token!
            expect(User.exists?(session_token: new_token)).to be true
        end
    end
    
    describe "#ensure_session_token" do

        it "should be called after initialization" 

        it "should create a session token if one doesn't already exist" do
           user.session_token = nil 
           user.ensure_session_token
           expect(user.session_token).not_to eq nil
        end

        it "should not change session token if one doesn't already exist" do
            old_token = user.session_token
            user.ensure_session_token
            expect(user.session_token).to eq(old_token)
        end
    end

end 