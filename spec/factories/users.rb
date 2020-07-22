FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "password" }

    trait :invalid do
      email { nil }
    end
  end
end
