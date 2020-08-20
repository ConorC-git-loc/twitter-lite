require 'rails_helper'

RSpec.describe 'Tweets', type: :request do
  let(:user) { FactoryBot.create(:user) }

  subject do
    sign_in user
  end

  describe 'validations' do
    it 'returns http success' do
      get '/tweets/new'
      expect(response).to have_http_status(:found)
    end

    it 'should save successfully' do
      tweet = Tweet.new(content: 'New tweet').save
      expect(tweet).to eq(true)
    end
  end
end
