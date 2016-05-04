require 'rails_helper'

RSpec.describe TopicsController, type: :controller do
  let :my_topic do
    Topic.create! name: RandomData.random_sentence, description: RandomData.random_paragraph
  end

  describe 'GET index' do
    before(:each) {get :index}

    it 'returns http success' do
      expect(response).to have_http_status :success
    end

    it 'assigns my_topic to @topics' do
      expect(assigns :topics).to eq [my_topic]
    end
  end

  describe 'GET show' do
    before(:each) { get :show, id: my_topic.id }

    it 'returns http success' do
      expect(response).to have_http_status :success
    end

    it 'renders the #show view' do
      expect(response).to render_template :show
    end

    it 'assigns my_topic to @topic' do
      expect(assigns :topic).to eq my_topic
    end
  end

  describe 'GET new' do
    before(:each) { get :new }

    it 'returns http success' do
      expect(response).to have_http_status :success
    end

    it 'renders the #new view' do
      expect(response).to render_template :new
    end

    it 'initializes @topic' do
      expect(assigns :topic).not_to be_nil
    end
  end

  describe 'POST create' do
    before :each do
      post :create, {topic: {name: RandomData.random_sentence, description: RandomData.random_paragraph}}
    end

    it 'increases the number of topics by 1' do
      expect do
        post :create, {topic: {name: RandomData.random_sentence, description: RandomData.random_paragraph}}
      end.to change(Topic, :count).by 1
    end

    it 'assigns Topic.last to @topic' do
      expect(assigns :topic).to eq Topic.last
    end

    it 'redirects to the new topic' do
      expect(response).to redirect_to Topic.last
    end
  end

  describe 'GET edit' do
    before(:each) { get :edit, id: my_topic }

    it 'returns http success' do
      expect(response).to have_http_status :success
    end

    it 'renders the #edit view' do
      expect(response).to render_template :edit
    end

    it 'assigns topic to be updated to @topic' do
      topic_instance = assigns :topic

      expect(topic_instance.id).to eq my_topic.id
      expect(topic_instance.name).to eq my_topic.name
      expect(topic_instance.description).to eq my_topic.description
    end
  end

  describe 'PUT update' do
    let(:new_name) {RandomData.random_sentence}
    let(:new_description) {RandomData.random_paragraph}
    before :each do
      put :update, id: my_topic.id, topic: {name: new_name, description: new_description}
    end

    it 'updates topic with expected attributes' do
      updated_topic = assigns :topic
      expect(updated_topic.id).to eq my_topic.id
      expect(updated_topic.name).to eq new_name
      expect(updated_topic.description).to eq new_description
    end

    it 'redirects to the updated topic' do
      expect(response).to redirect_to my_topic
    end
  end

  describe 'DELETE destroy' do
    before(:each) {delete :destroy, id: my_topic.id}

    it 'deletes the topic' do
      count = Topic.where(id: my_topic.id).size
      expect(count).to eq 0
    end

    it 'redirects to topics index' do
      expect(response).to redirect_to topics_path
    end
  end
end
