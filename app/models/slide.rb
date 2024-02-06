class Slide < ApplicationRecord
  # associations
  belongs_to :carousel
  has_many :quill_contents
end
