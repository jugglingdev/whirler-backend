require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    let(:user) {create(:user)}

    before do
      user
      get "/users"
    end
    
    it 'returns a sucessful response' do
      expect(response).to be_successful
    end

    it 'returns a response with all the users' do
      expect(response.body).to eq(User.all.to_json)
    end
  end

  describe "GET /post/:id" do
    let(:user) {create(:user)}

    before do
      get "/users/#{user.id}"
    end

    it 'returns a sucessful response' do
      expect(response).to be_successful
    end

    it 'returns a response with the correct user' do
      expect(response.body).to eq(user.to_json)
    end
  end

  describe 'POST /users' do
    context 'with valid params' do
      before do
        user_attributes = attributes_for(:user)
        post '/users', params: user_attributes
      end

      it 'returns a sucessful response' do
        expect(response).to be_successful
      end

      it 'creates a new user' do
        expect(User.count).to eq(1)
      end
    end

    context 'with invalid params' do
      before do
        user_attributes = attributes_for(:user, email: nil)
        post '/users', params: user_attributes
      end

      it 'returns a response with errors' do
        expect(response.status).to eq(422)
      end
    end
  end

  describe "PUT /users/:id" do
    context 'with valid params' do
      let(:user) {create(:user)}

      before do
        user_attributes = { email: "johndoe123@test.com" }
        put "/users/#{user.id}", params: user_attributes
      end

      it 'updates an user' do
        user.reload
        expect(user.email).to eq('johndoe123@test.com')
      end

      it 'returns a sucessful response' do
        expect(response).to be_successful
      end
    end

    context 'with invalid params' do
      let(:user) {create(:user)}
      
      before do
        user_attributes = { email: nil }
        put "/users/#{user.id}", params: user_attributes
      end

      it 'returns a response with errors' do
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'DELETE /user/:id' do
    let(:user) {create(:user)}

    before do
      delete "/users/#{user.id}"
    end

    it 'deletes an user' do
      expect(User.count).to eq(0)
    end

    it 'returns a successful response' do
      expect(response).to be_successful
    end
  end

  describe "GET /users/:id/carousels" do
    
    let(:user) {create(:user)}
    let(:carousels) {create_list(:carousel, 3, user: user)}

    before do
      carousels
      get "/users/#{user.id}/carousels"
    end
    
    it 'returns a sucessful response' do
      expect(response).to be_successful
    end

    it 'returns a response with all the carousels by the given user' do
      carousel_titles = carousels.map(&:title)
      expect(JSON.parse(response.body).map { |carousel| carousel["title"] }).to match_array(carousel_titles)
    end
  end
end
