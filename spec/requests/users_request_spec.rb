require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe 'validations' do
    it 'blocks unauthenticated access' do
      sign_in nil
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'allows authenticated access' do
      sign_in
      get :index
      expect(response).to be_success
    end
  end
end
