require 'rails_helper'
include SessionsHelper

RSpec.describe CommentsController, type: :controller do
  let(:my_user) do
    User.create! name: 'Bloccit User', email: 'user@bloccit.com', password: 'helloworld'
  end
  let(:other_user) do
    User.create! name: RandomData.random_name, email: RandomData.random_email, password: 'helloworld', role: :member
  end
  let(:my_topic) do
    Topic.create! name: RandomData.random_sentence, description: RandomData.random_paragraph
  end
  let(:my_post) do
    my_topic.posts.create! title: RandomData.random_sentence, body: RandomData.random_paragraph, user: my_user
  end
  let(:my_comment) do
    Comment.create! body: 'Comment Body', post: my_post, user: my_user
  end

  context 'guest' do
    describe 'POST create' do
      it 'redirects the user to the sign in view' do
        post :create, format: :js, post_id: my_post.id, comment: {body: RandomData.random_paragraph}
        expect(response).to redirect_to new_session_path
      end
    end

    describe 'DELETE destroy' do
      it 'redirects the user to the sign in view' do
        delete :destroy, format: :js, post_id: my_post.id, id: my_comment.id
        expect(response).to redirect_to new_session_path
      end
    end
  end

  context "member user doing CRUD on a comment they don't own" do
    before do
      create_session other_user
    end

    describe 'POST create' do
      it 'increases the number of comments by 1' do
        expect do
          post :create, format: :js, post_id: my_post.id, comment: {body: RandomData.random_sentence}
        end.to change(Comment, :count).by 1
      end

      it 'returns http success' do
        post :create, format: :js, post_id: my_post.id, comment: {body: RandomData.random_paragraph}
        expect(response).to have_http_status :success
      end
    end

    describe 'DELETE destroy' do
      it 'redirects the user to the posts show view' do
        delete :destroy, format: :js, post_id: my_post.id, id: my_comment.id
        expect(response).to redirect_to [my_topic, my_post]
      end
    end
  end

  context 'member user doing CRUD on a comment they own' do
    before do
      create_session my_user
    end

    describe 'POST create' do
      it 'increases the number of comments by 1' do
        expect do
          post :create, format: :js, post_id: my_post.id, comment: {body: RandomData.random_sentence}
        end.to change(Comment, :count).by 1
      end

      it 'returns http success' do
        post :create, format: :js, post_id: my_post.id, comment: {body: RandomData.random_paragraph}
        expect(response).to have_http_status :success
      end
    end

    describe 'DELETE destroy' do
      before :each do
        delete :destroy, format: :js, post_id: my_post.id, id: my_comment.id
      end

      it 'deletes the comment' do
        count = Comment.where(id: my_comment.id).count
        expect(count).to eq 0
      end

      it 'returns http success' do
        expect(response).to have_http_status :success
      end
    end
  end

  context "admin user doing CRUD on a comment they don't own" do
    before do
      other_user.admin!
      create_session other_user
    end

    describe 'POST create' do
      it 'increases the number of comments by 1' do
        expect do
          post :create, format: :js, post_id: my_post.id, comment: {body: RandomData.random_sentence}
        end.to change(Comment, :count).by 1
      end

      it 'returns http success' do
        post :create, format: :js, post_id: my_post.id, comment: {body: RandomData.random_sentence}
        expect(response).to have_http_status :success
      end
    end

    describe 'DELETE destroy' do
      before :each do
        delete :destroy, format: :js, post_id: my_post.id, id: my_comment.id
      end

      it 'deletes the comment' do
        count = Comment.where(id: my_comment.id).count
        expect(count).to eq 0
      end

      it 'returns http success' do
        expect(response).to have_http_status :success
      end
    end
  end
end
