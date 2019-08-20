FactoryBot.define do
  factory :reservation do
    user { nil }
    room { nil }
    start_date { "2019-08-20 12:41:40" }
    end_date { "2019-08-20 12:41:40" }
    price { 1 }
    total { 1 }
  end
end
