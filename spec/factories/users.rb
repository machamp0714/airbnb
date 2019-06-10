FactoryBot.define do
  factory :alice, class: User do
    name { 'alice' }
    email { 'alice@email.com' }
    password { 'password' }
  end

  factory :bob, class: User do
    name { 'bob' }
    email { 'bob@email.com' }
    password { 'password' }
  end
end
