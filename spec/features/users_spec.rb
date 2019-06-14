require 'rails_helper'

RSpec.feature 'users', type: :feature do
  let(:user) { FactoryBot.build(:alice) }

  scenario 'ユーザー登録できる事' do
    visit root_path
    click_link '新規登録'
    fill_in 'ユーザー名', with: user.name
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    expect {
      click_on '登録'
    }.to change(User, :count).by(1)
    expect(current_path).to eq root_path
  end
end
