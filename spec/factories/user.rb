FactoryBot.define do 
    factory :user do 
        email {FFaker::Internet.email}
        name {FFaker::Name.name}
        avatar {Rack::Test::UploadedFile.new (Rails.root.join("app/assets/images/default-avatar.png"))}
        password {"password"}
        password_confirmation {"password"}
    end
end