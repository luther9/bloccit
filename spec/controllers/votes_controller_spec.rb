require 'rails_helper'
include SessionsHelper

RSpec.describe VotesController, type: :controller do
  let(:my_user) { create :user }
  let(:other_user) { create :user }
  let(:my_topic) { create :topic }
  let(:user_post) { create :post }
  let(:my_vote) { create :vote }

  context("guest") {
    describe("POST up_vote") {
      it("redirects the user to the sign in view") {
        post :up_vote, post_id: user_post.id
        expect(response).to redirect_to new_session_path
      }
    }

    describe("POST down_vote") {
      it("redirects the user to the sign in view") {
        post :down_vote, post_id: user_post.id
        expect(response).to redirect_to new_session_path
      }
    }
  }

  context("signed in user") {
    before {
      create_session my_user
      request.env["HTTP_REFERER"] = topic_post_path my_topic, user_post
    }

    describe("POST up_vote") {
      it("the users first vote increases number of post votes by one") {
        votes = user_post.votes.count
        post :up_vote, post_id: user_post.id
        expect(user_post.votes.count).to eq votes + 1
      }

      it("the users second vote does not increase the number of votes") {
        post :up_vote, post_id: user_post.id
        votes = user_post.votes.count
        post :up_vote, post_id: user_post.id
        expect(user_post.votes.count).to eq votes
      }

      it("increases the sum of post votes by one") {
        points = user_post.points
        post :up_vote, post_id: user_post.id
        expect(user_post.points).to eq points + 1
      }

      it(":back redirects to posts show page") {
        request.env["HTTP_REFERER"] = topic_post_path my_topic, user_post
        post :up_vote, post_id: user_post.id
        expect(response).to redirect_to [my_topic, user_post]
      }

      it(":back redirects to posts topic show") {
        request.env["HTTP_REFERER"] = topic_path my_topic
        post :up_vote, post_id: user_post.id
        expect(response).to redirect_to my_topic
      }
    }

    describe("POST down_vote") {
      it("the users first vote increases number of post votes by one") {
        votes = user_post.votes.count
        post :down_vote, post_id: user_post.id
        expect(user_post.votes.count).to eq votes + 1
      }

      it("the users second vote does not increase the number of votes") {
        post :down_vote, post_id: user_post.id
        votes = user_post.votes.count
        post :down_vote, post_id: user_post.id
        expect(user_post.votes.count).to eq votes
      }

      it("decreases the sum of post votes by one") {
        points = user_post.points
        post :down_vote, post_id: user_post.id
        expect(user_post.points).to eq points - 1
      }

      it(":back redirects to posts show page") {
        request.env["HTTP_REFERER"] = topic_post_path my_topic, user_post
        post :down_vote, post_id: user_post.id
        expect(response).to redirect_to [my_topic, user_post]
      }

      it(":back redirects to posts topic show") {
        request.env["HTTP_REFERER"] = topic_path my_topic
        post :down_vote, post_id: user_post.id
        expect(response).to redirect_to my_topic
      }
    }
  }
end
