require 'rails_helper'

RSpec.feature 'sessions', type: :feature do
  let(:user) { FactoryBot.create(:alice) }

  scenario 'ログイン出来る事', js: true do
    sign_in_as user
    expect(page).to have_content 'ログインしました。'
    expect(page).to have_current_path(root_path)
  end

  scenario 'ログアウトできる事' do
    sign_in_as user
    click_link 'Logout'
    expect(page).to have_current_path(root_path)
  end
end
