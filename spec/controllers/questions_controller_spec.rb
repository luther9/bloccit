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
    before(:each) {get :index}

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'assigns [question] to @questions' do
      expect(assigns :questions).to eq [question]
    end
  end

  describe "GET #new" do
    before(:each) {get :new}

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'renders the #new view' do
      expect(response).to render_template :new
    end

    it 'instantiates @question' do
      expect(assigns :question).not_to be_nil
    end
  end

  describe "GET #show" do
    before(:each) {get :show, id: question.id}

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'renders the #show view' do
      expect(response).to render_template :show
    end

    it 'assigns question to @question' do
      expect(assigns :question).to eq question
    end
  end

  describe 'POST create' do
    before :each do
      post :create, question: {
        title: RandomData.random_sentence,
        body: RandomData.random_paragraph,
        resolved: rand(2) == 1
      }
    end

    it 'increases the number of Question by 1' do
      expect do
        post :create, question: {
          title: RandomData.random_sentence,
          body: RandomData.random_paragraph,
          resolved: rand(2) == 1
        }
      end.to change(Question, :count).by 1
    end

    it 'assigns the new question to @question' do
      expect(assigns :question).to eq Question.last
    end

    it 'redirects to the new question' do
      expect(response).to redirect_to Question.last
    end
  end

  describe 'PUT update' do
    it 'updates questions with expected attributes' do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      new_resolved = rand(2) == 1

      put :update, id: question.id, question: {
        title: new_title,
        body: new_body,
        resolved: new_resolved
      }

      updated = assigns :question
      expect(updated.id).to eq question.id
      expect(updated.title).to eq new_title
      expect(updated.body).to eq new_body
      expect(updated.resolved).to eq new_resolved
    end

    it 'redirects to the updated question' do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      new_resolved = rand(2) == 1

      put :update, id: question.id, question: {
        title: new_title,
        body: new_body,
        resolved: new_resolved
      }
      expect(response).to redirect_to question
    end
  end

  describe 'DELETE destroy' do
    before(:each) {delete :destroy, id: question.id}

    it 'deletes the question' do
      count = Question.where(id: question.id).size
      expect(count).to eq 0
    end

    it 'redirects to question index' do
      expect(response).to redirect_to questions_path
    end
  end
end
