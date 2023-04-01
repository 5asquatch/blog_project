FactoryBot.define do
    factory :comment do 
        association :post
        body {FFaker::Lorem.paragraph}

    end
end