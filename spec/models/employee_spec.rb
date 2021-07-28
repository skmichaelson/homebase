require 'rails_helper'

RSpec.describe Employee do
  describe 'associations' do
    it { should have_many(:shifts) }
  end
end