class User < ActiveRecord::Base
  has_many :posts
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
end
