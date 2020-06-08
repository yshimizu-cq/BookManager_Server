FactoryBot.define do
  factory :book do
    association :user # 関連するuserオブジェクトも自動的に作成
    name { "sample_book" }
    image_url { "" }
    price { 3000 }
    purchase_date { "2020-06-01" }
  end
end
