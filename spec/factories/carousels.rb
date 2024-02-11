FactoryBot.define do
  factory :carousel do
    title { Faker::Lorem.words(number: 3) }
    description { Faker::Lorem.sentence }
    thumbnail { Faker::Placeholdit.image }
    user
    # tags { [association(:tag)] }
  end
end
