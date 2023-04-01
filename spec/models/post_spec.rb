require "rails_helper"

RSpec.describe Post, type: :model do
    describe "validations" do
        it "is valid with valid attributes" do
        post = FactoryBot.build(:post)
        expect(post).to be_valid
        end
    
        it "is not valid without a title" do
            post = FactoryBot.build(:post, title: nil)
            expect(post).to_not be_valid
        end

        it "is not valid without a body" do
            post = FactoryBot.build(:post, body: nil)
            expect(post).to_not be_valid
        end

        it "is not valid without a image" do
            post = FactoryBot.build(:post, image: nil)
            expect(post).to_not be_valid
        end

    end
end 