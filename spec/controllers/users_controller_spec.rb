require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    let(:user) { FactoryBot.create(:user) }
    let(:another_user) { FactoryBot.create(:user) }
  
    describe "GET #show" do
      it "returns http success" do
        sign_in user
        get :show, params: { id: another_user.id }
        expect(response).to have_http_status(:success)
      end
    end
  
    describe "GET #search" do
      it "returns http success" do
        sign_in user
        get :search
        expect(response).to have_http_status(:success)
      end
  
      it "returns http success when searching for a user" do
        sign_in user
        get :search, params: { search: another_user.name }
        expect(response).to have_http_status(:success)
      end
    end
  
    describe "POST #follow" do
      it "follows a user" do
        sign_in user
        post :follow, params: { id: another_user.id }
        expect(user.following?(another_user)).to be true
      end
  
      it "redirects to user profile page" do
        sign_in user
        post :follow, params: { id: another_user.id }
        expect(response).to redirect_to(user_path(another_user))
      end
  
      it "displays an error message when already following a user" do
        sign_in user
        post :follow, params: { id: another_user.id }
        post :follow, params: { id: another_user.id }
        expect(flash[:alert]).to eq("You are already following this user.")
      end
    end
  
    describe "POST #unfollow" do
      it "unfollows a user" do
        sign_in user
        post :follow, params: { id: another_user.id }
        post :unfollow, params: { id: another_user.id }
        expect(user.following?(another_user)).to be false
      end
  
      it "redirects to user profile page" do
        sign_in user
        post :follow, params: { id: another_user.id }
        post :unfollow, params: { id: another_user.id }
        expect(response).to redirect_to(user_path(another_user))
      end
  
      it "displays an error message when not following a user" do
        sign_in user
        post :unfollow, params: { id: another_user.id }
        expect(flash[:notice]).to eq("Cannot unfollow")
      end
    end
  
    describe "GET #followers" do
      it "returns http success" do
        sign_in user
        get :followers, params: { id: another_user.id }
        expect(response).to have_http_status(:success)
      end
    end
  
    describe "GET #subscribes" do
      it "returns http success" do
        sign_in user
        get :subscribes, params: { id: another_user.id }
        expect(response).to have_http_status(:success)
      end
    end
  end