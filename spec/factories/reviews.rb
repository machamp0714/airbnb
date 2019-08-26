FactoryBot.define do
  factory :review do
    comment { "MyText" }
    star { 1 }
    room { nil }
    reservation { nil }
    host { nil }
    guest { nil }
    type { "" }
  end
end
