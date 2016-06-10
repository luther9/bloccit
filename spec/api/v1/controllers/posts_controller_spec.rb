require 'rails_helper'

RSpec.describe(Api::V1::PostsController, type: :controller) {
  let!(:my_topic) {create :topic}
  let!(:my_post) {create :post, topic: my_topic}
  before {
    @new_post = build :post
  }

  describe("PUT update") {
    before {
      put :update, id: my_post.id, post: {title: @new_post.title, body: @new_post.body}
    }

    it("returns http success") {
      expect(response).to have_http_status :success
    }

    it("returns json content type") {
      expect(response.content_type).to eq 'application/json'
    }

    it("updates a post with the correct attributes") {
      updated_post = Post.find my_post.id
      expect(response.body).to eq updated_post.to_json
    }
  }

  describe("POST create") {
    before {
      post :create, post: {title: @new_post.title, body: @new_post.body}
    }

    it("returns http success") {
      expect(response).to have_http_status :success
    }

    it("returns json content type") {
      expect(response.content_type).to eq 'application/json'
    }

    it('creates a post with the correct attributes') {
      hashed_json = JSON.parse response.body
      expect(hashed_json['title']).to eq @new_post.title
      expect(hashed_json['body']).to eq @new_post.body
    }
  }

  describe("DELETE destroy") {
    before {delete :destroy, id: my_post.id}

    it("returns http success") {
      expect(response).to have_http_status :success
    }

    it("returns json content type") {
      expect(response.content_type).to eq 'application/json'
    }

    it("returns the correct json success message") {
      expect(response.body).to eq({message: 'Post destroyed', status: 200}.to_json)
    }

    it('deletes my_post') {
      expect {
        Post.find my_post.id
      }.to raise_exception ActiveRecord::RecordNotFound
    }
  }
}
