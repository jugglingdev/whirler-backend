class Tag < ApplicationRecord
    # validations
    validates :name, presence: true, length: { maximum: 50 }

    # associations
    has_and_belongs_to_many :carousels
end
