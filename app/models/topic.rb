class Topic < ActiveRecord::Base
  has_many :posts, dependent: :destroy
  has_many :labelings, as: :labelable
  has_many :labels, through: :labelings

  scope :visible_to, -> user {
    if user
      all
    else
      publicly_viewable
    end
  }

  scope :publicly_viewable, -> {
    where public: true
  }

  scope :privately_viewable, -> {
    where public: false
  }
end
