require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    let(:user) { User.new(first_name: 'John', last_name: 'Doe', email: 'john.doe@example.com', password: 'password', password_confirmation: 'password') }

    it 'is valid with all fields' do
      expect(user).to be_valid
    end

    it 'is invalid without a first name' do
      user.first_name = nil
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("First name can't be blank")
    end

    it 'is invalid without a last name' do
      user.last_name = nil
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'is invalid without an email' do
      user.email = nil
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it 'is invalid without a password' do
      user.password = nil
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'is invalid without a password confirmation' do
      user.password_confirmation = nil
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'is invalid if password and password_confirmation do not match' do
      user.password_confirmation = 'differentpassword'
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'is invalid with a non-unique email (case insensitive)' do
      User.create(first_name: 'Jane', last_name: 'Doe', email: 'john.doe@example.com', password: 'password', password_confirmation: 'password')
      duplicate_user = user.dup
      expect(duplicate_user).to_not be_valid
      expect(duplicate_user.errors.full_messages).to include("Email has already been taken")
    end

    it 'is invalid if password is too short' do
      user.password = 'short'
      user.password_confirmation = 'short'
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    let(:user) { User.create(first_name: 'John', last_name: 'Doe', email: 'john.doe@example.com', password: 'password', password_confirmation: 'password') }

    it 'authenticates with correct email and password' do
      authenticated_user = User.authenticate_with_credentials('john.doe@example.com', 'password')
      expect(authenticated_user).to eq(user)
    end

    it 'returns nil for incorrect password' do
      authenticated_user = User.authenticate_with_credentials('john.doe@example.com', 'wrongpassword')
      expect(authenticated_user).to be_nil
    end

    it 'authenticates email with spaces before and after' do
      authenticated_user = User.authenticate_with_credentials('  john.doe@example.com  ', 'password')
      expect(authenticated_user).to eq(user)
    end

    it 'authenticates email case-insensitively' do
      authenticated_user = User.authenticate_with_credentials('JOHN.DOE@EXAMPLE.COM', 'password')
      expect(authenticated_user).to eq(user)
    end
  end
end
