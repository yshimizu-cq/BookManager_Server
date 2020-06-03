FactoryBot.define do
  factory :book do
    image_url { "MyString" }
    name { "MyString" }
    price { 1 }
    purchase_date { "2020-06-03" }
    user { nil }
  end
end
