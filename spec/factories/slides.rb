FactoryBot.define do
  factory :slide do
    title { Faker::Lorem.words(number: 3) }
    carousel
  end
end
