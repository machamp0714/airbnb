require 'rails_helper'

RSpec.feature 'AccountActivations', type: :feature do
  feature 'ユーザー登録' do
    let(:user) { FactoryBot.build(:not_activated) }

    scenario 'ユーザー登録の際、アカウント有効化の為のメールが送信されること' do
      visit login_path
      click_link '新規登録'
      fill_in 'ユーザー名', with: user.name
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      expect {
        click_on '登録'
      }.to change(ActionMailer::Base.deliveries, :count).by(1)
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
