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

    it("PUT update returns http unauthenticated") {
      new_user = build :user
      put :update, id: my_user.id, user: {name: new_user.name, email: new_user.email, password: new_user.password}
      expect(response).to have_http_status 401
    }

    it("POST create returns http unauthenticated") {
      new_user = build :user
      post :create, user: {name: new_user.name, email: new_user.email, password: new_user.password}
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

    it("PUT update returns http forbidden") {
      new_user = build :user
      put :update, id: my_user.id, user: {name: new_user.name, email: new_user.email, password: new_user.password}
      expect(response).to have_http_status 403
    }

    it("POST create returns http forbidden") {
      new_user = build :user
      post :create, user: {name: new_user.name, email: new_user.email, password: new_user.password}
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

    describe("PUT update") {
      context("with valid attributes") {
        before {
          @new_user = build :user
          put :update, id: my_user.id, user: {name: @new_user.name, email: @new_user.email, password: @new_user.password, role: "admin"}
        }

        it("returns http success") {
          expect(response).to have_http_status :success
        }

        it("returns json content type") {
          expect(response.content_type).to eq 'application/json'
        }

        it("updates a user with the correct attributes") {
          hashed_json = JSON.parse response.body
          expect(hashed_json['name']).to eq @new_user.name
          expect(hashed_json['email']).to eq @new_user.email
          expect(hashed_json['role']).to eq 'admin'
        }
      }

      context("with invalid attributes") {
        before {
          put :update, id: my_user.id, user: {name: '', email: 'bademail@', password: 'short'}
        }

        it("returns http error") {
          expect(response).to have_http_status 400
        }

        it("returns the correct json error message") {
          expect(response.body).to eq ({error: "User update failed", status: 400}.to_json)
        }
      }
    }

    describe("POST create") {
      context("with valid attributes") {
        before {
          @new_user = build :user
          post :create, user: {name: @new_user.name, email: @new_user.email, password: @new_user.password, role: 'admin'}
        }

        it("returns http success") {
          expect(response).to have_http_status :success
        }

        it("returns json content type") {
          expect(response.content_type).to eq 'application/json'
        }

        it("creates a user with the correct attributes") {
          hashed_json = JSON.parse response.body
          expect(hashed_json['name']).to eq @new_user.name
          expect(hashed_json['email']).to eq @new_user.email
          expect(hashed_json['role']).to eq 'admin'
        }
      }

      context("with invalid attributes") {
        before {
          post :create, user: {name: '', email: 'bademail@', password: 'short'}
        }

        it("returns http error") {
          expect(response).to have_http_status 400
        }

        it("returns the correct json error message") {
          expect(response.body).to eq({"error": "User is invalid", "status": 400}.to_json)
        }
      }
    }
  }
}
