require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:post) { FactoryBot.create(:post) }
  

  before do
    sign_in user
  end

  describe "#create" do
    context "when user hasn't liked the post yet" do
      it "creates a new like for the post" do
        expect {
          post :create, params: { post_id: post.id }
        }.to change { post.likes.count }.by(1)
      end

      it "redirects to the post" do
        post :create, params: { post_id: post.id }
        expect(response).to redirect_to(post_path(post))
      end
    end

    context "when user has already liked the post" do
      before do
        post.likes.create(user_id: user.id)
      end

      it "does not create a new like for the post" do
        expect {
          post :create, params: { post_id: post.id }
        }.not_to change { post.likes.count }
      end

      it "sets a flash notice" do
        post :create, params: { post_id: post.id }
        expect(flash[:notice]).to eq("You can't like more than once")
      end

      it "redirects to the post" do
        post :create, params: { post_id: post.id }
        expect(response).to redirect_to(post_path(post))
      end
    end
  end

  describe "#destroy" do
    let!(:like) { post.likes.create(user_id: user.id) }

    context "when user has liked the post" do
      it "destroys the like for the post" do
        expect {
          delete :destroy, params: { post_id: post.id, id: like.id }
        }.to change { post.likes.count }.by(-1)
      end

      it "redirects to the post" do
        delete :destroy, params: { post_id: post.id, id: like.id }
        expect(response).to redirect_to(post_path(post))
      end
    end

    context "when user has not liked the post" do
      before do
        like.destroy
      end

      it "does not destroy any likes" do
        expect {
          delete :destroy, params: { post_id: post.id, id: like.id }
        }.not_to change { post.likes.count }
      end

      it "sets a flash notice" do
        delete :destroy, params: { post_id: post.id, id: like.id }
        expect(flash[:notice]).to eq("Cannot unlike")
      end

      it "redirects to the post" do
        delete :destroy, params: { post_id: post.id, id: like.id }
        expect(response).to redirect_to(post_path(post))
      end
    end
  end
end
