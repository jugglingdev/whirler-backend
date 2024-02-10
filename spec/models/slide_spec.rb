require 'rails_helper'

RSpec.describe Slide, type: :model do
    context 'validation test' do
        it 'has a title shorter than 255 characters' do
          slide = build(:slide, title: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false))
          expect(slide).not_to be_valid
        end
    end
    
    context 'association tests' do
        it 'belongs to a carousel' do
          slide = build(:slide)
          expect(slide.carousel).to be_present
        end

        it 'has many quill_contents' do
          slide = create(:slide)
          create_list(:quill_content, 3, slide: slide)
    
          slide.reload
          expect(slide.quill_contents.count).to eq(3)
        end
    end

    context 'destroy slide and quill_contents dependent on it' do
      let (:slide) {create(:slide)}
      let (:slide_id) {slide.id}
  
      before do
        slide.destroy
      end
  
      it 'deletes quill_contents' do
        quill_contents = QuillContent.where(slide_id: slide_id)
        expect(quill_contents).to be_empty
      end
    end
end
