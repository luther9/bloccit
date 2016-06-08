require 'rails_helper'

RSpec.describe(Api::V1::CommentsController, type: :controller) {
  let(:my_user) { create :user }
  let(:my_post) { create :post }
  let(:my_comment) {
    Comment.create! body: 'Comment Body', post: my_post, user: my_user
  }

  it("GET index returns http success") {
    get :index
    expect(response).to have_http_status :success
  }

  it("GET show returns http success") {
    get :show, id: my_comment.id
    expect(response).to have_http_status :success
  }
}
