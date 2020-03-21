require 'rails_helper'

RSpec.describe "Users", type: :request do
	let(:user) { FactoryBot.create(:user) }


	describe "validations" do
     it "blocks unauthenticated access" do
      sign_in nil
    
      get :index
    
    expect(response).to redirect_to(new_user_session_path)
  end
end
end
