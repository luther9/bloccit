require 'rails_helper'

RSpec.describe Labeling, type: :model do
  it do
    is_expected.to belong_to :labelable
  end
end
