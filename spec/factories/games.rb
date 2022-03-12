FactoryBot.define do
  factory :game do
    name { "MyString" }
    condition { 1 }
    price { 1 }
    stock { 1 }
    display { true }
    discription { "MyText" }
    user { nil }
    category { nil }
    platform { nil }
  end
end
