require 'rails_helper'

RSpec.describe(Api::V1::UsersController, type: :controller) {
  let(:my_user) { create :user }

  context("unauthenticated users") {
    it("GET index returns http unauthenticated") {
      get :index
      expect(response).to have_http_status 401
    }

    it("GET show returns http unauthenticated") {
      get :show, id: my_user.id
      expect(response).to have_http_status 401
    }
  }

  context("authenticated and unauthorized users") {
    before {
      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials my_user.auth_token
    }

    it("GET index returns http forbidden") {
      get :index
      expect(response).to have_http_status 403
    }

    it("GET show returns http forbidden") {
      get :show, id: my_user.id
      expect(response).to have_http_status 403
    }
  }

  context("authenticated and authorized users") {
    before {
      my_user.admin!
      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials my_user.auth_token
    }

    describe("GET index") {
      before { get :index }

      it("returns http success") {
        expect(response).to have_http_status :success
      }

      it("returns json content type") {
        expect(response.content_type).to eq "application/json"
      }

      it("returns my_user serialized") {
        expect(response.body).to eq [my_user].to_json
      }
    }

    describe("GET show") {
      before { get :show, id: my_user.id }

      it("returns http success") {
        expect(response).to have_http_status :success
      }

      it("returns json content type") {
        expect(response.content_type).to eq 'application/json'
      }

      it("returns my_user serialized") {
        expect(response.body).to eq my_user.to_json
      }
    }
  }
}
