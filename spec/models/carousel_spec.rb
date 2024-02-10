require 'rails_helper'

RSpec.describe Carousel, type: :model do
    context 'validation tests' do
        it 'is not valid without a title' do
          carousel = build(:carousel, title: nil);
          expect(carousel).not_to be_valid
        end
    
        it 'has a title shorter than 255 characters' do
          carousel = build(:carousel, title: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false))
          expect(carousel).not_to be_valid
        end

        it 'has a description shorter than 500 characters' do
            carousel = build(:carousel, title: Faker::Lorem.paragraph_by_chars(number: 501, supplemental: false))
            expect(carousel).not_to be_valid
          end
      end
    
      context 'association tests' do
        it 'belongs to a user' do
          carousel = build(:carousel)
          expect(carousel.user).to be_present
        end

        it 'has many slides' do
          carousel = create(:carousel)
          create_list(:slide, 3, carousel: carousel)
    
          carousel.reload
          expect(carousel.slides.count).to eq(3)
        end
      end
    
      context 'destroy carousel and slides dependent on it' do
        let (:carousel) {create(:carousel)}
        let (:carousel_id) {carousel.id}
    
        before do
          carousel.destroy
        end
    
        it 'deletes slides' do
          slides = Slide.where(carousel_id: carousel_id)
          expect(slides).to be_empty
        end
      end
end
