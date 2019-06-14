require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  
  describe "account_activation" do
    let(:user) { FactoryBot.create(:alice) }
    let(:mail) { UserMailer.account_activation(user) }

    before do
      @user_email = CGI.escape(user.email)
      @token = user.activation_token
      @activation_link = "http://localhost:3000/account_activations/#{@token}/edit?email=#{@user_email}"
    end

    it 'headerが正しいこと' do
      expect(mail.subject).to eq 'Account Activation'
      expect(mail.to).to eq [user.email]
      expect(mail.from).to eq ['no-reply-airbnb@example.com']
    end

    it 'bodyにアカウント有効かリンクが含まれている事' do
      expect(mail.body.parts[1].body.raw_source).to include @activation_link
    end
  end
end
