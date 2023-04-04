FactoryBot.define do 
    factory :user do 
        id { FFaker::Random.rand(1..9999) }
        email {FFaker::Internet.email}
        name {FFaker::Name.name}
        avatar {Rack::Test::UploadedFile.new (Rails.root.join("app/assets/images/default-avatar.png"))}
        password {"password"}
        password_confirmation {"password"}
    end
end