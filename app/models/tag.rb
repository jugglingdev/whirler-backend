class Tag < ApplicationRecord
    # validations
    validates :name, length: { maximum: 50 }

    # associations
    has_and_belongs_to_many :carousels
end
