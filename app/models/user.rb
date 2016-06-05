class User < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  before_save do
    if email.present?
      self.email = email.downcase
    end
  end
  before_save do
    self.role ||= :member
  end

  validates :name, length: {minimum: 1, maximum: 100}, presence: true
  validates :password, unless: :password_digest, presence: true, length: {minimum: 6}
  validates :password, length: {minimum: 6}, allow_blank: true
  validates :email, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 3, maximum: 254}

  has_secure_password

  enum role: [:member, :admin]

  def favorite_for post
    favorites.where(post_id: post.id).first
  end

  def avatar_url size
    gravatar_id = Digest::MD5::hexdigest(self.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end

  def posts_or_comments?
    !(posts.empty? && comments.empty?)
  end
end
