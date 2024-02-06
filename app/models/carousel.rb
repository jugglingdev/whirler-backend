class Carousel < ApplicationRecord
  # validations
  validates :title, presence: true, length: { maximum: 255 }
  validates :description, length: { maximum: 500 }

  # associations
  belongs_to :user
  has_and_belongs_to_many :tags
end
