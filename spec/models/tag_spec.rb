require 'rails_helper'

RSpec.describe Tag, type: :model do
    context 'validation tests' do
        it 'is not valid without a name' do
            tag = build(:tag, name: nil);
            expect(tag).not_to be_valid
        end
    
        it 'has a name shorter than 50 characters' do
            tag = build(:tag, name: Faker::Lorem.paragraph_by_chars(number: 51, supplemental: false))
            expect(tag).not_to be_valid
        end
    end

    context 'association tests' do
        it 'belongs to a carousel' do
            carousel = create(:carousel)
            tag = create(:tag, carousels: [carousel])
            expect(tag.carousels).to be_present
        end

        it 'has many carousels' do
            tag = create(:tag)
            create_list(:carousel, 3, tags: [tag])
    
            tag.reload
            expect(tag.carousels.count).to eq(3)
        end
    end
end
