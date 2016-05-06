require 'rails_helper'

RSpec.describe SponsoredPostsController, type: :controller do
  let :my_topic do
    Topic.create! name: RandomData.random_sentence, description: RandomData.random_paragraph
  end
  let :my_sponsored_post do
    my_topic.sponsored_posts.create! title: RandomData.random_sentence, body: RandomData.random_paragraph, price: rand(1000)
  end

  describe "GET #show" do
    before(:each) {get :show, topic_id: my_topic.id, id: my_sponsored_post.id}

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'renders the #show view' do
      expect(response).to render_template :show
    end

    it 'assigns my_sponsored_post to @sponsored_post' do
      expect(assigns :sponsored_post).to eq my_sponsored_post
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

    it 'instantiates @sponsored_post' do
      expect(assigns :sponsored_post).not_to be_nil
    end
  end

  describe "GET #edit" do
    before(:each) {get :edit, topic_id: my_topic.id, id: my_sponsored_post.id}

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'renders the #edit view' do
      expect(response).to render_template :edit
    end

    it 'assigns post to be updated to @sponsored_post' do
      sponsored_post_instance = assigns :sponsored_post

      expect(sponsored_post_instance.id).to eq my_sponsored_post.id
      expect(sponsored_post_instance.title).to eq my_sponsored_post.title
      expect(sponsored_post_instance.body).to eq my_sponsored_post.body
      expect(sponsored_post_instance.price).to eq my_sponsored_post.price
    end
  end

  describe 'POST create' do
    before :each do
      post :create, topic_id: my_topic.id, sponsored_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: rand(1000)}
    end

    it 'increases the number of SponsoredPost by 1' do
      expect do
        post :create, topic_id: my_topic.id, sponsored_post: {
          title: RandomData.random_sentence,
          body: RandomData.random_paragraph,
          price: rand(1000)
        }
      end.to change(SponsoredPost, :count).by 1
    end

    it 'assigns the new sponsored_post to @sponsored_post' do
      expect(assigns :sponsored_post).to eq SponsoredPost.last
    end

    it 'redirects to the new sponsored_post' do
      expect(response).to redirect_to [my_topic, SponsoredPost.last]
    end
  end

  describe 'PUT update' do
    let(:new_title) {RandomData.random_sentence}
    let(:new_body) {RandomData.random_paragraph}
    let(:new_price) {rand 1000}

    before :each do
      put :update, topic_id: my_topic.id, id: my_sponsored_post.id, sponsored_post: {title: new_title, body: new_body, price: new_price}
    end

    it 'updates sponsored_posts with expected attributes' do
      updated_post = assigns :sponsored_post
      expect(updated_post.id).to eq my_sponsored_post.id
      expect(updated_post.title).to eq new_title
      expect(updated_post.body).to eq new_body
      expect(updated_post.price).to eq new_price
    end

    it 'redirects to the updated post' do
      expect(response).to redirect_to [my_topic, my_sponsored_post]
    end
  end

  describe 'DELETE destroy' do
    before :each do
      delete :destroy, topic_id: my_topic.id, id: my_sponsored_post.id
    end

    it 'deletes the post' do
      count = SponsoredPost.where(id: my_sponsored_post.id).size
      expect(count).to eq 0
    end

    it 'redirects to topic show' do
      expect(response).to redirect_to my_topic
    end
  end
end
