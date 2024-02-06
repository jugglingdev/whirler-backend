class Slide < ApplicationRecord
  # validations
  validates :title, length: { maximum: 255 }

  # associations
  belongs_to :carousel
  has_many :quill_contents
end
