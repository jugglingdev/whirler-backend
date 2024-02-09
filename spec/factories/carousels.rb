FactoryBot.define do
  factory :carousel do
    title { Faker::Lorem.words(num = 3, supplemental = false) }
    description { Faker::Lorem.sentence }
    thumbnail { Faker::Placeholdit.image }
    user
  end
end
