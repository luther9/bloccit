class FavoriteMailer < ApplicationMailer
  default from: 'lutheroto@gmail.com'

  def new_comment user, post, comment
    headers["Message-ID"] = "<comments/#{comment.id}@polar-bayou-90760.example>"
    headers["In-Reply-To"] = "<post/#{post.id}@polar-bayou-90760.example>"
    headers["References"] = "<post/#{post.id}@polar-bayou-90760.example>"

    @user = user
    @post = post
    @comment = comment

    mail to: user.email, subject: "New comment on #{post.title}", cc: 'linojon@gmail.com'
  end

  def new_post user, post
    headers["Message-ID"] = "<posts/#{post.id}@polar-bayou-90760.example>"
    headers["In-Reply-To"] = "<post/#{post.id}@polar-bayou-90760.example>"
    headers["References"] = "<post/#{post.id}@polar-bayou-90760.example>"

    @user = user
    @post = post

    mail to: user.email, subject: "You have created a post: #{post.title}", cc: 'linojon@gmail.com'
  end
end
