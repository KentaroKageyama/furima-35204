FactoryBot.define do
  factory :order_shipping_address do
    token             { "tok_abcdefghijk00000000000000000" }
    zip_code          { '123-4567' }
    prefecture_id     { Faker::Number.within(range: 2..48) }
    city              { Gimei.city.kanji }
    address           { Gimei.town.kanji }
    building          { Gimei.town.katakana }
    phone_number      { Faker::Number.number(digits: 11) }
  end
end
