require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:topic) { create :topic }

  it { is_expected.to have_many :posts }
  it do
    is_expected.to have_many :labelings
  end
  it do
    is_expected.to have_many(:labels).through :labelings
  end

  describe 'attributes' do
    it 'responds to name and description attributes' do
      expect(topic).to have_attributes name: topic.name, description: topic.description
    end

    it 'is public by default' do
      expect(topic.public).to be true
    end
  end

  describe("scopes") {
    before {
      @public_topic = create :topic
      @private_topic = create :topic, public: false
    }

    describe("visible_to(user)") {
      it("returns all topics if the user is present") {
        user = User.new
        expect(Topic.visible_to user).to eq Topic.all
      }

      it("returns only public topics if user is nil") {
        expect(Topic.visible_to nil).to eq [@public_topic]
      }
    }

    describe('publicly_viewable') {
      it('returns all public topics') {
        expect(Topic.publicly_viewable).to eq [@public_topic]
      }
    }
  }
end
