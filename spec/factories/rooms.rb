# frozen_string_literal: true

FactoryBot.define do
  factory :room do
    home_type { "MyString" }
    room_type { "MyString" }
    accommodate { 1 }
    bed_room { 1 }
    bath_room { 1 }
    listing_name { "MyString" }
    summary { "MyText" }
    address { "MyString" }
    is_tv { false }
    is_kitchen { false }
    is_air { false }
    is_heating { false }
    is_internet { false }
    price { 1 }
    active { false }
    user { nil }
  end
end
