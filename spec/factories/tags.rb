FactoryBot.define do
  factory :tag do
    name { Faker::Lorem.word }
    carousels { [association(:carousel)] }
  end
end
