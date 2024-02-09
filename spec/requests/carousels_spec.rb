require 'rails_helper'

RSpec.describe "Carousels", type: :request do
  describe "GET /carousels" do
    it "works! (now write some real specs)" do
      get carousels_index_path
      expect(response).to have_http_status(200)
    end
  end
end
