require 'rails_helper'

RSpec.feature 'AccountActivations', type: :feature do
  feature 'ユーザー登録' do
    background do
      ActionMailer::Base.deliveries.clear
    end

    # def extract_activation_url(mail)
    #   body = mail.body.encoded
    #   body[/http[^"]+/]
    # end

    let(:user) { FactoryBot.build(:not_activated) }

    scenario 'ユーザー登録の際、メールが送信され、アカウントを有効化出来ること', js: true do
      visit root_path
      click_link 'Sign Up'
      fill_in 'ユーザー名', with: user.name
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      expect {
        click_button '登録'
        sleep 1
      }.to change { ActionMailer::Base.deliveries.size }.by(1)

      expect(page).to have_content 'まだ登録は完了していません。アカウントの有効化をしてください。'
    end

  end
  feature 'ログイン' do
    let(:user) { FactoryBot.create(:not_activated) }

    scenario '有効化されていないユーザーはログインできないこと', js: true do
      sign_in_as user
      expect(page).to have_current_path(root_path)
      expect(page).to have_content 'アカウントは有効ではありません。'
    end
  end
end
