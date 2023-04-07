require "rails_helper"

RSpec.describe Comment, type: :model do
    describe "validations" do
        it "is valid with valid attributes" do
        post = FactoryBot.build(:post)
        comment = FactoryBot.build(:comment)
        expect(comment).to be_valid
        end
    end
    it "is not valid without a body" do
        comment = FactoryBot.build(:comment, body: nil)
        expect(comment).to_not be_valid
    end
    it "is not valid without a post" do
        comment = FactoryBot.build(:comment)
        if comment.post != nil
            expect(comment).to be_valid
        else
            expect(comment).to_not be_valid
        end
    end

end