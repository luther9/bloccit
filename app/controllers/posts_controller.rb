class PostsController < ApplicationController
  def index
    @posts = Post.all
    @posts.each do |p|
      if p.id % 5 == 1
        p.title = 'SPAM'
      end
    end
  end

  def show
  end

  def new
  end

  def edit
  end
end
