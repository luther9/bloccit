require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:topic) { create :topic }
  let(:user) { create :user }
  let(:post) { create :post }

  it do
    is_expected.to have_many :labelings
  end
  it do
    is_expected.to have_many(:labels).through :labelings
  end

  it do
    is_expected.to have_many :comments
  end
  it {
    is_expected.to have_many :votes
  }
  it {
    is_expected.to have_many :favorites
  }
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
    it 'has title and body attributes' do
      expect(post).to have_attributes title: post.title, body: post.body
    end
  end

  describe("voting") {
    before {
      3.times {
        post.votes.create! value: 1
      }
      2.times {
        post.votes.create! value: -1
      }
      @up_votes = post.votes.where(value: 1).count
      @down_votes = post.votes.where(value: -1).count
    }

    describe("#up_votes") {
      it("counts the number of votes with value = 1") {
        expect(post.up_votes).to eq @up_votes
      }
    }

    describe("#down_votes") {
      it("counts the number of votes with value = -1") {
        expect(post.down_votes).to eq @down_votes
      }
    }

    describe("#points") {
      it("returns the sum of all down and up votes") {
        expect(post.points).to eq @up_votes - @down_votes
      }
    }

    describe("#update_rank") {
      it("calculates the correct rank") {
        post.update_rank
        expect(post.rank).to eq post.points + (post.created_at - Time.new(1970, 1, 1)) / 1.day.seconds
      }

      it("updates the rank when an up vote is created") {
        old_rank = post.rank
        post.votes.create! value: 1
        expect(post.rank).to eq old_rank + 1
      }

      it("updates the rank when a down vote is created") {
        old_rank = post.rank
        post.votes.create! value: -1
        expect(post.rank).to eq old_rank - 1
      }
    }
  }
end
