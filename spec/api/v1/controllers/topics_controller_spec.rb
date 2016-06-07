require 'rails_helper'

RSpec.describe(Api::V1::TopicsController, type: :controller) {
  let(:my_user) { create :user }
  let(:my_topic) { create :topic }

  context("unauthenticated user") {
    it("GET index returns http success") {
      get :index
      expect(response).to have_http_status :success
    }

    it("GET show returns http success") {
      get :show, id: my_topic.id
      expect(response).to have_http_status :success
    }
  }

  context("unauthorized user") {
    before {
      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials my_user.auth_token
    }

    it("GET index returns http success") {
      get :index
      expect(response).to have_http_status :success
    }

    it("GET show returns http success") {
      get :show, id: my_topic.id
      expect(response).to have_http_status :success
    }
  }
}
