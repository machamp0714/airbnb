require 'rails_helper'

RSpec.feature 'users', type: :feature do
  let(:user) { FactoryBot.build(:not_activated) }

  scenario 'ユーザー登録できる事', js: true do
    visit root_path
    click_link 'Sign Up'
    expect {
      fill_in 'ユーザー名', with: user.name
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_on '登録'
      sleep 1
    }.to change(User, :count).by(1)
    expect(page).to have_current_path(root_path)
    expect(page).to have_content 'まだ登録は完了していません。アカウントの有効化をしてください。'
  end
end
