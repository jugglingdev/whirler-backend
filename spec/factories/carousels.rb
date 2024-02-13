FactoryBot.define do
  factory :carousel do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence }
    thumbnail { Faker::Placeholdit.image }
    user
  end
end
