require 'rails_helper'

RSpec.describe "QuillContents", type: :request do
  describe "GET /quill_contents" do
    let(:quill_content) {create(:quill_content)}

    before do
      quill_content
      get "/quill_contents"
    end
    
    it 'returns a sucessful response' do
      expect(response).to be_successful
    end

    it 'returns a response with all the quill_contents' do
      expect(response.body).to eq(QuillContent.all.to_json)
    end
  end

  describe "GET /quill_content/:id" do
    let(:quill_content) {create(:quill_content)}

    before do
      get "/quill_contents/#{quill_content.id}"
    end

    it 'returns a sucessful response' do
      expect(response).to be_successful
    end

    it 'returns a response with the correct quill_content' do
      expect(response.body).to eq(quill_content.to_json)
    end
  end

  describe 'POST /quill_contents' do
    context 'with valid params' do
      let(:slide) {create(:slide)}

      before do
        quill_content_attributes = attributes_for(:quill_content, slide_id: slide.id)
        post '/quill_contents', params: quill_content_attributes
      end

      it 'returns a sucessful response' do
        expect(response).to be_successful
      end

      it 'creates a new quill_content' do
        expect(QuillContent.count).to eq(1)
      end
    end

    context 'with invalid params' do
      before do
        quill_content_attributes = attributes_for(:quill_content, slide_id: nil)
        post '/quill_contents', params: quill_content_attributes
      end

      it 'returns a response with errors' do
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PUT /quill_contents/:id" do
    context 'with valid params' do
      let(:quill_content) {create(:quill_content)}

      before do
        quill_content_attributes = attributes_for(:quill_content, x: 22.0)
        put "/quill_contents/#{quill_content.id}", params: quill_content_attributes
      end

      it 'updates a quill_content' do
        quill_content.reload
        expect(quill_content.x).to eq(22.0)
      end

      it 'returns a sucessful response' do
        expect(response).to be_successful
      end
    end

    context 'with invalid params' do
      let(:quill_content) {create(:quill_content)}
      
      before do
        quill_content_attributes = attributes_for(:quill_content, slide_id: nil)
        put "/quill_contents/#{quill_content.id}", params: quill_content_attributes
      end

      it 'returns a response with errors' do
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'DELETE /quill_content/:id' do
    let(:quill_content) {create(:quill_content)}

    before do
      delete "/quill_contents/#{quill_content.id}"
    end

    it 'deletes a quill_content' do
      expect(QuillContent.count).to eq(0)
    end

    it 'returns a successful response' do
      expect(response).to be_successful
    end
  end
end
