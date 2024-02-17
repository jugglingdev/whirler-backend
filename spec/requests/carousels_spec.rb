require 'rails_helper'

RSpec.describe "Carousels", type: :request do

  describe "GET /carousel/:id" do
    let(:user) {create(:user)}
    let(:carousel) {create(:carousel)}
    let(:token) { auth_token_for_user(user) }

    before do
      get "/carousels/#{carousel.id}", headers: { Authorization: "Bearer #{token}" }
    end

    it 'returns a sucessful response' do
      expect(response).to be_successful
    end

    it 'returns a response with the correct carousel' do
      expect(response.body).to eq(CarouselBlueprint.render(carousel, view: :carousel_edit))
    end
  end

  describe 'POST /carousels' do
    let(:user) {create(:user)}
    let(:token) { auth_token_for_user(user) }

    context 'with valid params' do
      before do
        carousel_attributes = attributes_for(:carousel, user_id: user.id)
        post '/carousels', params: carousel_attributes, headers: { Authorization: "Bearer #{token}" }
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
        post '/carousels', params: carousel_attributes, headers: { Authorization: "Bearer #{token}" }
      end

      it 'returns a response with errors' do
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PUT /carousels/:id" do
    let(:user) {create(:user)}
    let(:carousel) {create(:carousel)}
    let(:token) { auth_token_for_user(user) }

    context 'with valid params' do
      before do
        carousel_attributes = attributes_for(:carousel, title: "Updated Title")
        put "/carousels/#{carousel.id}", params: carousel_attributes, headers: { Authorization: "Bearer #{token}" }
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
      before do
        carousel_attributes = attributes_for(:carousel, title: nil)
        put "/carousels/#{carousel.id}", params: carousel_attributes, headers: { Authorization: "Bearer #{token}" }
      end

      it 'returns a response with errors' do
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'DELETE /carousel/:id' do
    let(:user) {create(:user)}
    let(:carousel) {create(:carousel)}
    let(:token) { auth_token_for_user(user) }

    before do
      delete "/carousels/#{carousel.id}", headers: { Authorization: "Bearer #{token}" }
    end

    it 'deletes a carousel' do
      expect(Carousel.count).to eq(0)
    end

    it 'returns a successful response' do
      expect(response).to be_successful
    end
  end

  describe "GET /carousels/:id/slides" do
    let(:user) {create(:user)}
    let(:carousel) {create(:carousel)}
    let(:slides) {create_list(:slide, 3, carousel: carousel)}
    let(:token) { auth_token_for_user(user) }

    before do
      slides
      get "/carousels/#{carousel.id}/slides", headers: { Authorization: "Bearer #{token}" }
    end
    
    it 'returns a sucessful response' do
      expect(response).to be_successful
    end

    it 'returns a response with all the carousel slides' do
      slide_titles = slides.map(&:title)
      expect(JSON.parse(response.body).map { |slide| slide["title"] }).to match_array(slide_titles)
    end
  end
end
