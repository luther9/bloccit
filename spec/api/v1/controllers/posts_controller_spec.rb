require 'rails_helper'

RSpec.describe(Api::V1::PostsController, type: :controller) {
  let!(:my_post) { create :post }

  describe("GET index") {
    before { get :index }

    it("returns http success") {
      expect(response).to have_http_status :success
    }

    it("returns json content type") {
      expect(response.content_type).to eq "application/json"
    }

    it('returns my_post serialized') {
      expect(response.body).to eq [my_post].to_json
    }
  }

  describe("GET show") {
    before { get :show, id: my_post.id }

    it("returns http success") {
      expect(response).to have_http_status :success
    }

    it("returns json content type") {
      expect(response.content_type).to eq "application/json"
    }

    it('returns my_post serialized') {
      expect(response.body).to eq my_post.to_json
    }
  }
}
