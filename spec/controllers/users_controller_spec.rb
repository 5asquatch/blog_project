require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    
    describe 'GET #followers' do
        context "when user is logged in" do
            it "renders the index page " do
                user = FactoryBot.create(:user)
                sign_in user
            end
        end
    end
end