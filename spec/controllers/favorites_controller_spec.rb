require 'rails_helper'
include SessionsHelper

RSpec.describe FavoritesController, type: :controller do
  let(:my_user) {
    User.create! name: "Bloccit User", email: "user@bloccit.com", password: "helloworld"
  }
  let(:my_topic) {
    Topic.create! name: RandomData.random_sentence, description: RandomData.random_paragraph
  }
  let(:my_post) {
    my_topic.posts.create! title: RandomData.random_sentence, body: RandomData.random_paragraph, user: my_user
  }

  context('guest user') {
    describe('POST create') {
      it('redirects the user to the sign in view') {
        post :create, post_id: my_post.id
        expect(response).to redirect_to new_session_path
      }
    }

    describe('DELETE destroy') {
      it('redirects the user to the sign in view') {
        favorite = my_user.favorites.where(post: my_post).create
        delete :destroy, post_id: my_post.id, id: favorite.id
        expect(response).to redirect_to new_session_path
      }
    }
  }

  context('signed in user') {
    before {
      create_session my_user
    }

    describe('POST create') {
      it('redirects to the posts show view') {
        post :create, post_id: my_post.id
        expect(response).to redirect_to [my_topic, my_post]
      }

      it('creates a favorite for the current user and specified post') {
        expect(my_user.favorites.find_by_post_id my_post.id).to be_nil

        post :create, post_id: my_post.id

        expect(my_user.favorites.find_by_post_id my_post.id).not_to be_nil
      }
    }

    describe('DELETE destroy') {
      it('redirects to the posts show view') {
        favorite = my_user.favorites.where(post: my_post).create
        delete :destroy, post_id: my_post.id, id: favorite.id
        expect(response).to redirect_to [my_topic, my_post]
      }

      it('destroys the favorite for the current user and post') {
        favorite = my_user.favorites.where(post: my_post).create
        expect(my_user.favorites.find_by_post_id my_post.id).not_to be_nil

        delete :destroy, post_id: my_post.id, id: favorite.id

        expect(my_user.favorites.find_by_post_id my_post.id).to be_nil
      }
    }
  }
end
