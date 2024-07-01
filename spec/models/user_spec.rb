require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should save a user with all four fields set' do
      user = User.new(
        email: 'test@test.com',
        first_name: 'Test',
        last_name: 'User',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to be_valid
    end

    it 'is invalid when password and password_confirmation do not match' do
      user = User.new(
        email: 'test@test.com',
        first_name: 'Test',
        last_name: 'User',
        password: 'password',
        password_confirmation: 'password1'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'is invalid when email is missing' do
      user = User.new(
        email: nil,
        first_name: 'Test',
        last_name: 'User',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it 'is invalid when first_name is missing' do
      user = User.new(
        email: 'test@test.com',
        first_name: nil,
        last_name: 'User',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("First name can't be blank")
    end

    it 'is invalid when last_name is missing' do
      user = User.new(
        email: 'test@test.com',
        first_name: 'Test',
        last_name: nil,
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'is invalid when password is missing' do
      user = User.new(
        email: 'test@test.com',
        first_name: 'Test',
        last_name: 'User',
        password: nil,
        password_confirmation: 'password'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'is invalid when password_confirmation is missing' do
      user = User.new(
        email: 'test@test.com',
        first_name: 'Test',
        last_name: 'User',
        password: 'password',
        password_confirmation: nil
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'is invalid when a duplicate email is used (case insensitive)' do
      User.create(
        email: 'test@test.com',
        first_name: 'Test',
        last_name: 'User',
        password: 'password',
        password_confirmation: 'password'
      )
      user = User.new(
        email: 'TEST@test.com',
        first_name: 'Test',
        last_name: 'User',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Email has already been taken")
    end

    it 'is invalid when password is less than 6 characters' do
      user = User.new(
        email: 'test@test.com',
        first_name: 'Test',
        last_name: 'User',
        password: 'pass',
        password_confirmation: 'pass'
      )
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    before do
      @user = User.create(
        email: 'example@domain.com',
        first_name: 'Test',
        last_name: 'User',
        password: 'password',
        password_confirmation: 'password'
      )
    end

    it 'authenticates with correct email and password' do
      user = User.authenticate_with_credentials('example@domain.com', 'password')
      expect(user).to eq(@user)
    end

    it 'authenticates with email with leading/trailing spaces' do
      user = User.authenticate_with_credentials(' example@domain.com ', 'password')
      expect(user).to eq(@user)
    end

    it 'authenticates with email with different case' do
      user = User.authenticate_with_credentials('EXAMPLE@domain.com', 'password')
      expect(user).to eq(@user)
    end

    it 'does not authenticate with incorrect password' do
      user = User.authenticate_with_credentials('example@domain.com', 'wrongpassword')
      expect(user).to be_nil
    end

    it 'does not authenticate with incorrect email' do
      user = User.authenticate_with_credentials('example1@domain.com', 'password')
      expect(user).to be_nil
    end
  end
end
