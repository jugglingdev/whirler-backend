require 'rails_helper'

RSpec.describe User, type: :model do

  context 'validation tests' do
    it 'is valid with a username, email, password, and confirmation password' do
      user = build(:user, password: 'password1234', password_confirmation: 'password1234')
      expect(user).to be_valid
    end
  
    it 'is not valid without a username' do
      user = build(:user, username: nil)
      expect(user).not_to be_valid
    end

    it 'is not valid without an email' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    emails = ['joe', '123', '@this', 'joe@', 'joe@test', 'test.com']

    for email in emails do 
      it 'is not valid with an invalid email format' do
        user = build(:user, email: email)
        expect(user).not_to be_valid
      end
    end

    it 'is not valid without a password' do
      user = build(:user, password: nil)
      expect(user).not_to be_valid
    end

    it 'has a password that is at most 50 characters' do
      user = build(:user, password: Faker::Internet.password(min_length: 51, max_length: 60))
      expect(user).not_to be_valid
    end

    it 'has a password that is at least 12 characters' do
      user = build(:user, password: Faker::Internet.password(max_length: 11))
      expect(user).not_to be_valid
    end

    it 'hashes the password using BCrypt' do
      user = create(:user, password: 'password1234')
  
      expect(user.password_digest).not_to eq 'password1234'
  
      expect(BCrypt::Password.new(user.password_digest)).to be_truthy
  
      expect(BCrypt::Password.new(user.password_digest).is_password?('password1234')).to be true
    end
  end

  context 'uniqeness tests' do
    it 'is not valid without a unique email' do
      user1 = create(:user)
      user2 = build(:user, email: user1.email)

      expect(user2).not_to be_valid
      expect(user2.errors[:email]).to include("has already been taken")
    end
  end

  context 'association test' do
    it 'has many carousels' do
      user = create(:user)
      create_list(:carousel, 3, user: user)

      user.reload
      expect(user.carousels.count).to eq(3)
    end
  end

  context 'destroy user and carousels dependent on it' do
    let (:user) {create(:user)}
    let (:user_id) {user.id}

    before do
      user.destroy
    end

    it 'deletes carousels' do
      carousels = Carousel.where(user_id: user_id)
      expect(carousels).to be_empty
    end
  end
end
