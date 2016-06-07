require 'rails_helper'

RSpec.describe(Api::V1::BaseController, type: :controller) {
  let(:my_user) { create :user }

  context("authorized user") {
    before {
      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials my_user.auth_token
      controller.authenticate_user
    }

    describe("#authenticate_user") {
      it("finds a user by their authentication token") {
        expect(assigns :current_user).to eq my_user
      }
    }
  }
}
