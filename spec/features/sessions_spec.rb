require 'rails_helper'

RSpec.feature 'sessions', type: :feature do
  let(:user) { FactoryBot.create(:alice) }

  scenario 'ログイン出来る事' do
    visit root_path
    click_link 'ログイン'
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    within '#session' do
      click_on 'ログイン'
    end
    expect(page).to have_content 'ログインしました。'
    expect(current_path).to eq root_path
  end
end
