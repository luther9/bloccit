class Api::V1::CommentsController < Api::V1::BaseController
  def show
    comment = Comment.find params[:id]
    render json: comment, status: 200
  end

  def index
    comments = Comment.all
    render json: comments, status: 200
  end
end
