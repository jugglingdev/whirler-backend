FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(
      min_length: 12, 
      max_length: 50, 
      mix_case: true, 
      special_characters: true
      ) 
    }
  end
end
