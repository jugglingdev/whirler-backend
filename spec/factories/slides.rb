FactoryBot.define do
  factory :slide do
    title { Faker::Lorem.words(num = 3, supplemental = false) }
    carousel
  end
end
