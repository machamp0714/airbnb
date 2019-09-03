FactoryBot.define do
  factory :message do
    context { "MyText" }
    user { nil }
    conversation { nil }
  end
end
