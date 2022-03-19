FactoryBot.define do
  factory :order do
    game { nil }
    buyer { nil }
    seller { nil }
    payment_id { "MyString" }
    receipt_url { "MyString" }
  end
end
