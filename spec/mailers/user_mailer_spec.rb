require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "account_activation" do
    let(:user) { FactoryBot.create(:alice) }
    let(:mail) { UserMailer.account_activation(user) }

    it "renders the headers" do
      expect(mail.subject).to eq 'Account Activation'
      expect(mail.to).to eq [user.email]
      expect(mail.from).to eq ['no-reply-airbnb@example.com']
    end
  end
end
