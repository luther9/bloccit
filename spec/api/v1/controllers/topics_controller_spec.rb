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

    it("PUT update returns http unauthenticated") {
      put :update, id: my_topic.id, topic: {name: "Topic Name", description: "Topic Description"}
      expect(response).to have_http_status 401
    }

    it("POST create returns http unauthenticated") {
      post :create, topic: {name: "Topic Name", description: "Topic Description"}
      expect(response).to have_http_status 401
    }

    it("DELETE destroy returns http unauthenticated") {
      delete :destroy, id: my_topic.id
      expect(response).to have_http_status 401
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

    it("PUT update returns http forbidden") {
      put :update, id: my_topic.id, topic: {name: "Topic Name", description: "Topic Description"}
      expect(response).to have_http_status 403
    }

    it("POST create returns http forbidden") {
      post :create, topic: {name: "Topic Name", description: "Topic Description"}
      expect(response).to have_http_status 403
    }

    it("DELETE destroy returns http forbidden") {
      delete :destroy, id: my_topic.id
      expect(response).to have_http_status 403
    }
  }

  context("authenticated and authorized users") {
    before {
      my_user.admin!
      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials my_user.auth_token
      @new_topic = build :topic
    }

    describe("PUT update") {
      before {
        put :update, id: my_topic.id, topic: {name: @new_topic.name, description: @new_topic.description}
      }

      it("returns http success") {
        expect(response).to have_http_status :success
      }

      it("returns json content type") {
        expect(response.content_type).to eq 'application/json'
      }

      it("updates a topic with the correct attributes") {
        updated_topic = Topic.find my_topic.id
        expect(response.body).to eq updated_topic.to_json
      }
    }

    describe("POST create") {
      before {
        post :create, topic: {name: @new_topic.name, description: @new_topic.description}
      }

      it("returns http success") {
        expect(response).to have_http_status :success
      }

      it("returns json content type") {
        expect(response.content_type).to eq 'application/json'
      }

      it("creates a topic with the correct attributes") {
        hashed_json = JSON.parse response.body
        expect(hashed_json['name']).to eq @new_topic.name
        expect(hashed_json['description']).to eq @new_topic.description
      }
    }

    describe("DELETE destroy") {
      before { delete :destroy, id: my_topic.id }

      it("returns http success") {
        expect(response).to have_http_status :success
      }

      it("returns json content type") {
        expect(response.content_type).to eq 'application/json'
      }

      it("returns the correct json success message") {
        expect(response.body).to eq({message: "Topic destroyed", status: 200}.to_json)
      }

      it("deletes my_topic") {
        expect {
          Topic.find my_topic.id
        }.to raise_exception ActiveRecord::RecordNotFound
      }
    }
  }
}
