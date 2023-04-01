require "rails_helper"

RSpec.describe Comment, type: :model do
    describe "validations" do
        it "is valid with valid attributes" do
        post = FactoryBot.build(:post)
        comment = FactoryBot.build(:comment)
        expect(comment).to be_valid
        end
    end

end