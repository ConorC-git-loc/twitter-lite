
require 'rails_helper'

RSpec.describe Tweet, :type => :model do
  
  before(:all) do
    @tweet1 = create(:tweet)
  end
  
  it { should validate_presence_of(:tweet) }
  it { should validate_length_of(:tweet).is_at_most(255) }
  it { should validate_presence_of(:user) }
end
