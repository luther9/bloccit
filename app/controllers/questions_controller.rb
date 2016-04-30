class QuestionsController < ApplicationController
  def edit
    @question = Question.find params[:id]
  end

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def show
  end
end
