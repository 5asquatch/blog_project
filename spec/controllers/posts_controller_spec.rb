require 'rails_helper'

RSpec.describe PostsController, type: :controller do

    describe 'GET #index' do
        context "when user is logged in" do
            it "renders the index page " do
                user = FactoryBot.create(:user)
                sign_in user
                get :index
                expect(response).to render_template(:index)
            end
        end


        context "when user is logged in" do
            it "redirects to login page" do
                get :index
                expect(response).to redirect_to(new_user_session_path)
            end
        end

    end

    describe 'GET #show' do
        context "when user is logged in" do
            it "renders the show page " do
                user = FactoryBot.create(:user)
                post = FactoryBot.build(:post)
                expect(post).to be_valid
                sign_in user
                get :show
                expect(response).to render_template(:show)
             end
        end
    end

   

end