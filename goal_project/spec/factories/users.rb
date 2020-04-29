FactoryBot.define do
    factory :user do
        username { Faker::Beer.name }
        password { "password" }
    end
end