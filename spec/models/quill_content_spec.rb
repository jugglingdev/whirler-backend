require 'rails_helper'

RSpec.describe QuillContent, type: :model do
    context 'validation tests' do
        
        numbers = [-2, 0, -14.02]
        
        for number in numbers do
            it 'has a width greater than 0' do
                quill_content = build(:quill_content, width: number);
                expect(quill_content).not_to be_valid
            end

            it 'has a height greater than 0' do
                quill_content = build(:quill_content, height: number)
                expect(quill_content).not_to be_valid
            end
        end
        
    end
    
    context 'association test' do
        it 'belongs to a slide' do
          quill_content = build(:quill_content)
          expect(quill_content.slide).to be_present
        end
    end
end
