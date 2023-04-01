require "rails_helper"

RSpec.describe User, type: :model do
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
end