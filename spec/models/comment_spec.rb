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
  let(:comment) { Comment.create! body: 'Comment Body', post: post }

  describe 'attributes' do
    it 'has a body attribute'do
      expect(comment).to have_attributes body: 'Comment Body'
    end
  end
end
