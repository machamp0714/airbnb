FactoryBot.define do
  factory :setting do
    enable_sms { false }
    enable_email { "MyString" }
    user { nil }
  end
end
