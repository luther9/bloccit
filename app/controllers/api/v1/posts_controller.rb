class Api::V1::PostsController < Api::V1::BaseController
  def update
    post = Post.find params[:id]

    if post.update_attributes post_params
      render json: post, status: 200
    else
      render json: {error: 'Post update failed', status: 400}, status: 400
    end
  end

  def create
    post = Post.new post_params
    post.user_id = params[:user_id]
    post.topic_id = params[:topic_id]

    if post.valid?
      post.save!
      render json: post, status: 201
    else
      render json: {error: 'Post is invalid', status: 400}, status: 400
    end
  end

  def destroy
    post = Post.find params[:id]

    if post.destroy
      render json: {message: 'Post destroyed', status: 200}, status: 200
    else
      render json: {error: 'Post destroy failed', status: 400}, status: 400
    end
  end

  private

  def post_params
    params.require(:post).permit :title, :body
  end
end
