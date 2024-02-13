require 'rails_helper'

RSpec.describe "Slides", type: :request do
  describe "GET /slides" do
    let(:slide) {create(:slide)}

    before do
      slide
      get "/slides"
    end
    
    it 'returns a sucessful response' do
      expect(response).to be_successful
    end

    it 'returns a response with all the slides' do
      expect(response.body).to eq(Slide.all.to_json)
    end
  end

  describe "GET /slide/:id" do
    let(:slide) {create(:slide)}

    before do
      get "/slides/#{slide.id}"
    end

    it 'returns a sucessful response' do
      expect(response).to be_successful
    end

    it 'returns a response with the correct slide' do
      expect(response.body).to eq(slide.to_json)
    end
  end

  describe 'POST /slides' do
    context 'with valid params' do
      let(:carousel) {create(:carousel)}

      before do
        slide_attributes = attributes_for(:slide, carousel_id: carousel.id)
        post '/slides', params: slide_attributes
      end

      it 'returns a sucessful response' do
        expect(response).to be_successful
      end

      it 'creates a new slide' do
        expect(Slide.count).to eq(1)
      end
    end

    context 'with invalid params' do
      before do
        slide_attributes = attributes_for(:slide, carousel_id: nil)
        post '/slides', params: slide_attributes
      end

      it 'returns a response with errors' do
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PUT /slides/:id" do
    context 'with valid params' do
      let(:slide) {create(:slide)}

      before do
        slide_attributes = attributes_for(:slide, title: "Updated Title")
        put "/slides/#{slide.id}", params: slide_attributes
      end

      it 'updates a slide' do
        slide.reload
        expect(slide.title).to eq('Updated Title')
      end

      it 'returns a sucessful response' do
        expect(response).to be_successful
      end
    end

    context 'with invalid params' do
      let(:slide) {create(:slide)}
      
      before do
        slide_attributes = attributes_for(:slide, carousel_id: nil)
        put "/slides/#{slide.id}", params: slide_attributes
      end

      it 'returns a response with errors' do
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'DELETE /slide/:id' do
    let(:slide) {create(:slide)}

    before do
      delete "/slides/#{slide.id}"
    end

    it 'deletes a slide' do
      expect(Slide.count).to eq(0)
    end

    it 'returns a successful response' do
      expect(response).to be_successful
    end
  end
end
