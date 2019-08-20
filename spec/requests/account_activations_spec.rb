# frozen_string_literal: true

require "rails_helper"

RSpec.describe "AccountActivations", type: :request do
  let(:user) { FactoryBot.create(:not_activated) }

  describe "GET edit_account_activation_path" do
    it "アカウントが有効化されること" do
      get edit_account_activation_path(user.activation_token, email: user.email)
      expect(response.status).to eq 302
    end
  end
end
