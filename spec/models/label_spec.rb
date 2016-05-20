require 'rails_helper'

RSpec.describe Label, type: :model do
  let :topic do
    Topic.create! name: RandomData.random_sentence, description: RandomData.random_paragraph
  end
  let :user do
    User.create! name: "Bloccit User", email: "user@bloccit.com", password: "helloworld"
  end
  let :post do
    topic.posts.create! title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user
  end
  let :label do
    Label.create! name: 'Label'
  end
  let :label2 do
    Label.create! name: 'Label2'
  end

  it do
    is_expected.to have_many :labelings
  end
  it do
    is_expected.to have_many(:topics).through :labelings
  end
  it do
    is_expected.to have_many(:posts).through :labelings
  end

  describe "labelings" do
    it "allows the same label to be associated with a different topic and post" do
      topic.labels << label
      post.labels << label

      topic_label = topic.labels[0]
      post_label = post.labels[0]
      expect(topic_label).to eql post_label
    end
  end

  describe '.update_labels' do
    it "takes a comma delimited string and returns an array of Labels" do
      labels = "#{label.name}, #{label2.name}"
      labels_as_a = [label, label2]
      expect(Label.update_labels labels).to eq labels_as_a
    end
  end
end
