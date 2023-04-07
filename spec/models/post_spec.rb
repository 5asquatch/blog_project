require "rails_helper"

RSpec.describe Post, type: :model do
    let(:user) {FactoryBot.build(:user)}
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
        it "is not valid with an image larger than 2MB" do
            post = FactoryBot.build(:post, user: user, image: fixture_file_upload('large_image.jpg', 'image/jpg'))
            expect(post).to_not be_valid
          end
        
        it "is not valid with an image of an invalid content type" do
            post = FactoryBot.build(:post, user: user, image: fixture_file_upload('/invalid_type.pdf', 'application/pdf'))
            expect(post).to_not be_valid
        end
        
    end
end 