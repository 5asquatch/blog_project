require "rails_helper"

RSpec.describe User, type: :model do
let(:user) {FactoryBot.build(:user)}

subject(:user) { FactoryBot.create(:user) }

    describe "validations-short" do

    end

    describe "validations" do
        it "is valid with valid attributes" do
        user = FactoryBot.build(:user)
        expect(user).to be_valid
        end

        it "is not valid without a name" do
            user = FactoryBot.build(:user, name: nil)
            expect(user).to_not be_valid
        end

        it "is not valid without a email" do
            user = FactoryBot.build(:user, email: nil)
            expect(user).to_not be_valid
        end

        it "is not valid without a password" do
            user = FactoryBot.build(:user, password: nil, password_confirmation: nil)
            expect(user).to_not be_valid
        end

        it "is not valid without a avatar" do
            user = FactoryBot.build(:user, avatar: nil)
            expect(user).to_not be_valid
        end
    end   

     describe ".search" do
        it "returns all users when passed an empty search string" do
            expect(User.search("")).to match_array(User.all)
            end
        end

    describe "#following?" do
        it "returns true when user is following another user" do
          followed_user = FactoryBot.create(:user)
          FactoryBot.create(:follow, follower: user, followee: followed_user)
          expect(user.following?(followed_user)).to be_truthy
        end
      
        it "returns false when user is not following another user" do
          other_user = FactoryBot.create(:user)
          expect(user.following?(other_user)).to be_falsey
        end
    end
    
    describe "associations" do
        it "has many posts and destroys them when user is destroyed" do
        post = FactoryBot.create(:post, user: user)
        expect { user.destroy }.to change { Post.count }.by(-1)
        end
        #it "has many comments and destroys them when user is destroyed" do
        #    comment = FactoryBot.create(:comment, author: user)
        #    expect { user.destroy }.to change { Comment.count }.by(-1)
        #end
      
       it "has many likes and destroys them when user is destroyed" do
        like = FactoryBot.create(:like, user: user)
        expect { user.destroy }.to change { Like.count }.by(-1)
       end
      
       it "has many followed_users (as a follower) and follows them through follows table" do
        followed_user = FactoryBot.create(:user)
        follow = FactoryBot.create(:follow, follower: user, followee: followed_user)
        expect(user.followed_users).to include(follow)
        expect(user.followees).to include(followed_user)
       end
      
       it "has many following_users (as a followee) and is followed by them through follows table" do
        following_user = FactoryBot.create(:user)
        follow = FactoryBot.create(:follow, follower: following_user, followee: user)
        expect(user.following_users).to include(follow)
        expect(user.followers).to include(following_user)
       end
      
    end


end