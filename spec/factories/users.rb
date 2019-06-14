FactoryBot.define do
  factory :alice, class: User do
    name { 'alice' }
    email { 'alice@email.com' }
    password { 'password' }
    activated { true }
    activated_at { Time.zone.now }
  end

  factory :bob, class: User do
    name { 'bob' }
    email { 'bob@email.com' }
    password { 'password' }
    activated { true }
    activated_at { Time.zone.now }
  end

  factory :not_activated, class: User do
    name { 'not-activated' }
    email { 'not.activated@email.com' }
    password { 'password' }
    activated { false }
    activated_at { nil }
  end
end
