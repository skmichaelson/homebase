require 'rails_helper'

RSpec.describe Shift do
  describe 'associations' do
    it { should belong_to(:employee) }
  end
end