# frozen_string_literal: true

User.create!(
  name: "alice",
  email: "alice@email.com",
  password: "password",
  activated: true,
  activated_at: Time.zone.now
)

User.create!(
  name: "bob",
  email: "bob@email.com",
  password: "password",
  activated: false,
  activated_at: Time.zone.now
)
