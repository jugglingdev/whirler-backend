require 'rails_helper'

RSpec.describe User, type: :model do

  context 'validation tests' do
    it 'is not valid without an email' do
      user = build(:user, email: nil)
      expect(user).not_to be_valid
    end

    emails = ['joe', '123', '@this', 'joe@', 'joe@test', 'test.com']

    for email in emails do 
      it 'is not valid with invalid email format' do
        user = build(:user, email: email)
        expect(user).not_to be_valid
      end
    end

    it 'is not valid without a password' do
      user = build(:user, password: nil)
      expect(user).not_to be_valid
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
