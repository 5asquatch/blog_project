require 'rails_helper'

RSpec.describe PostsController, type: :controller do
    let(:user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post, user: user) }
    let(:valid_attributes) { FactoryBot.attributes_for(:post) } 
  
    before { sign_in user }
  
    describe "GET #index" do
      it "renders the index template" do
        get :index
        expect(response).to render_template(:index)
      end
      it "assigns the current user as @user" do
        get :index
        expect(assigns(:user)).to eq(user)
      end
  
      it "assigns the followees of the current user as @followees" do
        get :index
        expect(assigns(:followees)).to eq(user.followees)
      end
    end

    describe "GET #new" do
        it "renders the new template" do
        get :new
        expect(response).to render_template(:new)
        end
        it "assigns a new post to @post" do
            get :new
            expect(assigns(:post)).to be_a_new(Post)
          end
    end


    describe "GET #show" do
        it "renders the show template" do
        get :show, params: { id: post.id }
        expect(response).to render_template(:show)
        end

        it "assigns the requested post as @post" do
            get :show, params: { id: post.id }
            expect(assigns(:post)).to eq(post)
          end
    end


end