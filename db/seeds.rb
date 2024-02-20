(1..10).each do |i|
    user = User.create(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        username: Faker::Internet.username(specifier: 3..20, separators: %w(_)),
        email: Faker::Internet.email,
        password: 'Password123!',
        password_confirmation: 'Password123!'
    )

    rand(1..10).times do
        carousel = user.carousels.create(
            title: Faker::Lorem.sentence,
            description: Faker::Lorem.sentence,
            thumbnail: Faker::Placeholdit.image
        )

        rand(1..3).times do
            tag = Tag.create(name: Faker::Lorem.word)
            carousel.tags << tag
        end

        rand(1..10).times do
            slide = carousel.slides.create(
                title: Faker::Lorem.sentence
            )

            rand(1..5).times do
                slide.quill_contents.create(
                    width: Faker::Number.between(from: 0.0, to: 100.0),
                    height: Faker::Number.between(from: 0.0, to: 100.0),
                    x: Faker::Number.between(from: 0.0, to: 500.0),
                    y: Faker::Number.between(from: 0.0, to: 500.0),
                    delta: Faker::Json.shallow_json(
                        width: 2, 
                        options: { 
                            key: 'Lorem.word', 
                            value: 'Lorem.sentence' 
                        }
                    )
                )
            end
        end
    end
end
