class Api::V1::PostsController < Api::V1::BaseController
  def show
    post = Post.find params[:id]
    render json: post, status: 200
  end

  def index
    posts = Post.all
    render json: posts, status: 200
  end
end
