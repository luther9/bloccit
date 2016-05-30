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
end
