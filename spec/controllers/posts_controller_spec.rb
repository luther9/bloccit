require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let :my_topic do
    Topic.create! name: RandomData.random_sentence, description: RandomData.random_paragraph
  end
  let :my_post do
    my_topic.posts.create! title: RandomData.random_sentence, body: RandomData.random_paragraph
  end

  describe "GET #show" do
    before(:each) {get :show, topic_id: my_topic.id, id: my_post.id}

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'renders the #show view' do
      expect(response).to render_template :show
    end

    it 'assigns my_post to @post' do
      expect(assigns :post).to eq my_post
    end
  end

  describe "GET #new" do
    before(:each) {get :new, topic_id: my_topic.id}

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'renders the #new view' do
      expect(response).to render_template :new
    end

    it 'instantiates @post' do
      expect(assigns :post).not_to be_nil
    end
  end

  describe 'POST create' do
    before :each do
      post :create, topic_id: my_topic.id, post: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
    end

    it 'increases the number of Post by 1' do
      expect do
        post :create, topic_id: my_topic.id, post: {
          title: RandomData.random_sentence,
          body: RandomData.random_paragraph
        }
      end.to change(Post, :count).by 1
    end

    it 'assigns the new post to @post' do
      expect(assigns :post).to eq Post.last
    end

    it 'redirects to the new post' do
      expect(response).to redirect_to [my_topic, Post.last]
    end
  end

  describe "GET #edit" do
    before(:each) {get :edit, topic_id: my_topic.id, id: my_post.id}

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'renders the #edit view' do
      expect(response).to render_template :edit
    end

    it 'assigns post to be updated to @post' do
      post_instance = assigns :post

      expect(post_instance.id).to eq my_post.id
      expect(post_instance.title).to eq my_post.title
      expect(post_instance.body).to eq my_post.body
    end
  end

  describe 'PUT update' do
    let(:new_title) {RandomData.random_sentence}
    let(:new_body) {RandomData.random_paragraph}

    before :each do
      put :update, topic_id: my_topic.id, id: my_post.id, post: {title: new_title, body: new_body}
    end

    it 'updates posts with expected attributes' do
      updated_post = assigns :post
      expect(updated_post.id).to eq my_post.id
      expect(updated_post.title).to eq new_title
      expect(updated_post.body).to eq new_body
    end

    it 'redirects to the updated post' do
      expect(response).to redirect_to [my_topic, my_post]
    end
  end

  describe 'DELETE destroy' do
    before(:each) {delete :destroy, topic_id: my_topic.id, id: my_post.id}

    it 'deletes the post' do
      count = Post.where(id: my_post.id).size
      expect(count).to eq 0
    end

    it 'redirects to topic show' do
      expect(response).to redirect_to my_topic
    end
  end
end
