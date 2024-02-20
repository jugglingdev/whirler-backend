FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    username { Faker::Internet.username(specifier: 3..20, separators: %w(_)) }
    email { Faker::Internet.email }
    password { 'password1234' }
    password_confirmation { 'password1234' }
  end
end
