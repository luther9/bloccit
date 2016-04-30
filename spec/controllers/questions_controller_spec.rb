require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let :question do
    Question.create! title: RandomData.random_sentence, body: RandomData.random_paragraph, resolved: rand(2) == 1
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, id: question.id
      expect(response).to have_http_status(:success)
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
