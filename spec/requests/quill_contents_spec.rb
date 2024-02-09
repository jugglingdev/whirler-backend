require 'rails_helper'

RSpec.describe "QuillContents", type: :request do
  describe "GET /quill_contents" do
    it "works! (now write some real specs)" do
      get quill_contents_index_path
      expect(response).to have_http_status(200)
    end
  end
end
