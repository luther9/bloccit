require 'rails_helper'

RSpec.describe Vote, type: :model do
  let(:topic) { create :topic }
  let(:user) { create :user }
  let(:post) { create :post }
  let(:vote) {
    Vote.create! value: 1, post: post, user: user
  }

  it {
    is_expected.to belong_to :post
  }
  it {
    is_expected.to belong_to :user
  }
  it {
    is_expected.to validate_presence_of :value
  }
  it {
    is_expected.to validate_inclusion_of(:value).in_array [-1, 1]
  }

  describe("update_post callback") {
    it("triggers update_post on save") {
      expect(vote).to receive(:update_post).at_least :once
      vote.save!
    }

    it("#update_post should call update_rank on post") {
      expect(post).to receive(:update_rank).at_least :once
      vote.save!
    }
  }
end
