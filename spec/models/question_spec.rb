require 'rails_helper'

RSpec.describe Question, type: :model do
  let :question do
    Question.create! title: 'Title', body: 'This is the text.', resolved: false
  end

  describe 'attributes' do
    it 'has title, body, resolved attributes' do
      expect(question).to have_attributes title: 'Title', body: 'This is the text.', resolved: false
    end
  end
end
