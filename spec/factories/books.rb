FactoryBot.define do
  factory :book do
    name { Faker::Book.title }
    image_url { '' }
    price { Faker::Number.number(digits: 4) }
    purchase_date { Faker::Date.between(from: 2.years.ago, to: Date.today) }

    association :user # 関連するuserオブジェクトも自動的に作成

    trait :invalid do
      name { nil }
    end

    trait :new_book do
      name { "new_book" }
    end
  end
end
