FactoryBot.define do
  factory :slide do
    title { Faker::Lorem.sentence }
    carousel
  end
end
