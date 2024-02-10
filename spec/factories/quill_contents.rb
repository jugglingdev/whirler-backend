FactoryBot.define do
  factory :quill_content do
    width { Faker::Number.between(from: 0.0, to: 100.0) }
    height { Faker::Number.between(from: 0.0, to: 100.0) }
    x { Faker::Number.between(from: 0.0, to: 500.0) }
    y { Faker::Number.between(from: 0.0, to: 500.0) }
    delta { Faker::Json.shallow_json(
      width: 2, 
      options: { 
        key: 'Lorem.word', 
        value: 'Lorem.sentence' 
      }
    )}
    slide
  end
end
