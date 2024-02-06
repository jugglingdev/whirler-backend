class QuillContent < ApplicationRecord
  # validations
  validates :width, :height, numericality: { greater_than: 0 }

  # associations
  belongs_to :slide
end
