Rails.configuration.stripe = {
  publishable_key: "pk_test_EUa7JpOmqqSfKsNmsCzBXXhk00T0BZhchn"
  secret_key: "sk_test_wmWQBB1RjtGjTBnkd5dMg4tc00eShYaCKU"
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]