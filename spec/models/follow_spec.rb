require "rails_helper"
RSpec.describe Follow, type: :model do
    let(:follower) { FactoryBot.create(:user) }
    let(:followee) { FactoryBot.create(:user) }
  
    describe "validations" do
      it "requires a unique follower_id/followee_id pair" do
        FactoryBot.create(:follow, follower: follower, followee: followee)
  
        follow = Follow.new(follower: follower, followee: followee)
        expect(follow).not_to be_valid
        expect(follow.errors[:follower_id]).to include("has already been taken")
      end
    end
  
    describe "associations" do
      it "belongs to follower" do
        expect(Follow.reflect_on_association(:follower).macro).to eq(:belongs_to)
      end
    
      it "belongs to followee" do
        expect(Follow.reflect_on_association(:followee).macro).to eq(:belongs_to)
      end
    end
    
  end