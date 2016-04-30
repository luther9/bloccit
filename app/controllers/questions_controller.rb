class QuestionsController < ApplicationController
  def edit
    @question = Question.find params[:id]
  end

  def index
  end

  def new
  end

  def show
  end
end
