require 'rails_helper'

RSpec.describe Answer, type: :model do
  let :answer do
    question = Question.create! title: 'Title', body: 'This is the text.', resolved: false
    Answer.create! body: 'Yes.', question: question
  end

  describe 'attributes' do
    it 'has a body attribute' do
      expect(answer).to have_attributes body: 'Yes.'
    end
  end
end
