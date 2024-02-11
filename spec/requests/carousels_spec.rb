require 'rails_helper'

RSpec.describe "Carousels", type: :request do
  describe "GET /carousels" do
    let(:carousel) {create(:carousel)}

    before do
      carousel
      get "/carousels"
    end
    
    it 'returns a sucessful response' do
      expect(response).to be_successful
    end

    it 'returns a response with all the carousels' do
      expect(response.body).to eq(Carousel.all.to_json)
    end
  end

  describe "GET /carousel/:id" do
    let(:carousel) {create(:carousel)}

    before do
      get "/carousels/#{carousel.id}"
    end

    it 'returns a sucessful response' do
      expect(response).to be_successful
    end

    it 'returns a response with the correct carousel' do
      expect(response.body).to eq(carousel.to_json)
    end
  end

  describe 'POST /carousels' do
    context 'with valid params' do
      let(:user) {create(:user)}

      before do
        carousel_attributes = attributes_for(:carousel, user_id: user.id)
        post '/carousels', params: carousel_attributes
      end

      it 'returns a sucessful response' do
        expect(response).to be_successful
      end

      it 'creates a new carousel' do
        expect(Carousel.count).to eq(1)
      end
    end

    context 'with invalid params' do
      before do
        carousel_attributes = attributes_for(:carousel, user_id: nil)
        post '/carousels', params: carousel_attributes
      end

      it 'returns a response with errors' do
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PUT /carousels/:id" do
    context 'with valid params' do
      let(:carousel) {create(:carousel)}

      before do
        carousel_attributes = attributes_for(:carousel, title: "Updated Title")
        put "/carousels/#{carousel.id}", params: carousel_attributes
      end

      it 'updates a carousel' do
        carousel.reload
        expect(carousel.title).to eq('Updated Title')
      end

      it 'returns a sucessful response' do
        expect(response).to be_successful
      end
    end

    context 'with invalid params' do
      let(:carousel) {create(:carousel)}
      
      before do
        carousel_attributes = attributes_for(:carousel, title: nil)
        put "/carousels/#{carousel.id}", params: carousel_attributes
      end

      it 'returns a response with errors' do
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'DELETE /carousel/:id' do
    let(:carousel) {create(:carousel)}

    before do
      delete "/carousels/#{carousel.id}"
    end

    it 'deletes a carousel' do
      expect(Carousel.count).to eq(0)
    end

    it 'returns a successful response' do
      expect(response).to be_successful
    end
  end
end
