require 'rails_helper'

RSpec.feature 'users', type: :feature do
  let(:user) { FactoryBot.build(:not_activated) }
  let(:alice) { FactoryBot.create(:alice) }

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

  scenario 'プロフィールを編集できること', js: true do
    sign_in_as alice
    sleep 5.5
    find('#navDropdown').click
    click_link 'Edit profile'
    fill_in 'ユーザー名', with: 'risa'
    fill_in '電話番号', with: '090-1234-5678'
    fill_in '自己紹介', with: 'hello!'
    fill_in 'メールアドレス', with: 'risa@gmail.com'
    fill_in 'パスワード', with: 'hogehoge'
    click_on 'Save'
    expect(page).to have_content 'Success!!'
  end
end
