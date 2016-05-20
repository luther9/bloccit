require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:name) { RandomData.random_sentence }
  let(:description) {RandomData.random_paragraph }
  let(:title) { RandomData.random_sentence }
  let(:body) { RandomData.random_paragraph }
  let(:topic) { Topic.create! name: name, description: description }
  let :user do
    User.create! name: 'Bloccit User', email: 'user@bloccit.com', password: 'helloworld'
  end
  let(:post) {topic.posts.create! title: title, body: body, user: user}

  it do
    is_expected.to have_many :labelings
  end
  it do
    is_expected.to have_many(:labels).through :labelings
  end

  it do
    is_expected.to have_many :comments
  end
  it { is_expected.to belong_to :topic }
  it do
    is_expected.to belong_to :user
  end

  it {is_expected.to validate_presence_of :title}
  it {is_expected.to validate_presence_of :body}
  it {is_expected.to validate_presence_of :topic}
  it {is_expected.to validate_presence_of :user}

  it {is_expected.to validate_length_of(:title).is_at_least 5}
  it {is_expected.to validate_length_of(:body).is_at_least 20}

  describe 'attributes' do
    it 'has title, body, and user attributes' do
      expect(post).to have_attributes title: title, body: body, user: user
    end
  end
end
