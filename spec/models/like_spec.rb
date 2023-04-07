require "rails_helper"

RSpec.describe Like, type: :model do
    describe "validations" do
        it "is valid with valid attributes" do
        user = FactoryBot.build(:user)
        like = FactoryBot.build(:like)
        expect(like).to be_valid
        end
    end

end