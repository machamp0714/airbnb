require 'rails_helper'

RSpec.feature 'sessions', type: :feature do
  let(:user) { FactoryBot.create(:alice) }

  scenario 'ログイン出来る事', js: true do
    sign_in_as user
    expect(page).to have_content 'ログインしました。'
    expect(current_path).to eq root_path
  end

  scenario 'ログアウトできる事' do
    sign_in_as user
    click_link 'ログアウト'
    # expect(page).to have_content 'ログアウトしました。'
    expect(current_path).to eq root_path
  end
end
