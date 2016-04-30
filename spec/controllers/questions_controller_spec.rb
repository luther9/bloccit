require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let :question do
    Question.create! title: RandomData.random_sentence, body: RandomData.random_paragraph, resolved: rand(2) == 1
  end

  describe "GET #edit" do
    before(:each) {get :edit, id: question.id}

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'renders the #edit view' do
      expect(response).to render_template :edit
    end

    it 'assigns updated question to @question' do
      my_question = assigns :question

      expect(my_question.id).to eq question.id
      expect(my_question.title).to eq question.title
      expect(my_question.body).to eq question.body
      expect(my_question.resolved).to eq question.resolved
    end
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, id: question.id
      expect(response).to have_http_status(:success)
    end
  end

end
