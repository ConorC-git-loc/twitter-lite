
require 'rails_helper'

RSpec.describe Tweet, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      expect(build_stubbed(:tweet)).to be_valid
    end

    it { should validate_presence_of(:tweet) }
    it { should validate_length_of(:tweet).is_at_most(255) }
    it { should validate_presence_of(:user) }
  end
end
