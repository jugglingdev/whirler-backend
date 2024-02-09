FactoryBot.define do
  factory :tag do
    name { Faker::Lorem.word }
    carousel
  end
end
