require 'rails_helper'

RSpec.describe Advertisement, type: :model do
  describe 'attributes' do
    it 'has title, body, and price attributes' do
      ad = Advertisement.create! title: 'Car', body: 'Buy our new Car!', price: 666
      expect(ad).to have_attributes title: 'Car', body: 'Buy our new Car!', price: 666
    end
  end
end
