require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
    let(:user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post) }
  
    describe "POST #create" do
      context "with authenticated user" do
        before { sign_in user } 
  
        it "creates a new comment" do
            post :create, params: { post_id: post.id, comment: { body: "test comment", author: "Test User" } }
        end
  
        it "redirects to the post" do
          post :create, params: { post_id: post.id, comment: { body: "test comment", author: "Test User" } }
          expect(response).to redirect_to post_path(post)
        end
      end
  
      context "with unauthenticated user" do
        it "redirects to the login page" do
          post :create, params: { post_id: post.id, comment: attributes_for(:comment) }
          expect(response).to redirect_to new_user_session_path
        end
      end
    end
  
    describe "PATCH #update" do
      let(:comment) { create(:comment, post: post) } # используем фабрику для создания комментария
  
      context "with authenticated user" do
        before { sign_in user }
  
        it "updates the comment" do
          patch :update, params: { post_id: post.id, id: comment.id, comment: { body: "Updated body" } }
          comment.reload
          expect(comment.body).to eq "Updated body"
        end
  
        it "redirects to the post" do
          patch :update, params: { post_id: post.id, id: comment.id, comment: attributes_for(:comment) }
          expect(response).to redirect_to post_path(post)
        end
      end
  
      context "with unauthenticated user" do
        it "redirects to the login page" do
          patch :update, params: { post_id: post.id, id: comment.id, comment: { body: "Updated body" } }
          expect(response).to redirect_to new_user_session_path
        end
      end
    end
  
    describe "DELETE #destroy" do
      let!(:comment) { create(:comment, post: post) } # используем фабрику для создания комментария
  
      context "with authenticated user" do
        before { sign_in user }
  
        it "destroys the comment" do
          expect {
            delete :destroy, params: { post_id: post.id, id: comment.id }
          }.to change(Comment, :count).by(-1)
        end
  
        it "redirects to the post" do
          delete :destroy, params: { post_id: post.id, id: comment.id }
          expect(response).to redirect_to post_path(post)
        end
      end
  
      context "with unauthenticated user" do
        it "redirects to the login page" do
          delete :destroy, params: { post_id: post.id, id: comment.id }
          expect(response).to redirect_to new_user_session_path
        end
      end
    end
end
  