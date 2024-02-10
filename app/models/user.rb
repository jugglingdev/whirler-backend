class User < ApplicationRecord
    # validations
    validates :email, presence: true, uniqueness: true,
        format: {
            with: URI::MailTo::EMAIL_REGEXP
        }
    validates :password, presence: true, length: { minimum: 12, maximum: 50 }

    # associations
    has_many :carousels
end
