FactoryBot.define do
  factory :user do
    username { Faker::Internet.username }
    email { Faker::Internet.email }
    password { 'password1234' }
    password_confirmation { 'password1234' }
  end
end
