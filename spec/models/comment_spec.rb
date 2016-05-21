require 'rails_helper'

RSpec.describe Comment, type: :model do
  let :topic do
    Topic.create! name: RandomData.random_sentence, description: RandomData.random_paragraph
  end
  let :user do
    User.create! name: 'Bloccit User', email: "user@bloccit.com", password: "helloworld"
  end
  let :post do
    topic.posts.create! title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user
  end
  let(:comment) do
    Comment.create! body: 'Comment Body', post: post, user: user
  end

  it do
    is_expected.to belong_to :post
  end
  it {
    is_expected.to belong_to :topic
  }
  it do
    is_expected.to belong_to :user
  end
  it do
    is_expected.to validate_presence_of :body
  end
  it do
    is_expected.to validate_length_of(:body).is_at_least 5
  end

  describe 'attributes' do
    it 'has a body attribute'do
      expect(comment).to have_attributes body: 'Comment Body'
    end
  end
end
