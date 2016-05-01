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
    @question = Question.find params[:id]
  end

  def create
    @question = Question.new
    @question.title = params[:question][:title]
    @question.body = params[:question][:body]
    @question.resolved = params[:question][:resolved]

    if @question.save
      flash[:notice] = 'Question was saved successfully.'
      redirect_to @question
    else
      flash.now[:alert] = 'There was an error saving the question. Please try again.'
      render :new
    end
  end
end
