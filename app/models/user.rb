class User < ApplicationRecord
    # validations
    validates :email, presence: true, uniqueness: true, length: { minimum: 5, maximum: 255 },
        format: {
            with: URI::MailTo::EMAIL_REGEXP
        }
    validates :password, presence: true, length: { minimum: 12, maximum: 50 }

    # associations
    has_many :carousels
end
