require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it "must be created with password and password_confirmation" do
      @user = User.create(first_name:'John', last_name: 'Smith', email: 'john@smith.ca', password: 'password', password_confirmation: 'password')
      expect(@user).to be_valid
    end

    it "must match password and password_confirmation" do
      @user = User.create(first_name:'Kate', last_name: 'Cross', email: 'kate@cross.ca', password: 'password', password_confirmation: 'chair')
      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "does not duplicate a pre-existing email registered" do
      @user1 = User.create(first_name:'Paul', last_name: 'Doppleganger', email: 'paul@ball.ca', password: 'password', password_confirmation: 'password')
      @user2 = User.create(first_name:'Paul', last_name: 'Ball', email: 'paul@ball.ca', password: 'password', password_confirmation: 'password')
      puts "ERROR MESSAGE: #{@user1.errors.full_messages}"
      puts "ERROR MESSAGE: #{@user2.errors.full_messages}"
      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end

    it "is not case sensitive with email input" do
      @user = User.create(first_name:'Coco', last_name: 'Larouse', email: 'COCO@gmail.ca', password: 'password', password_confirmation: 'password')
      expect(@user).to be_valid
      expect(@user.email).to match(/coco@gmail.ca/i)
    end

  end

  describe '.authenticate_with_credentials' do
    # examples for this class method here
  end

end
