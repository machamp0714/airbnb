module LoginSupport
  def sign_in_as(user)
    visit root_path
    click_link 'ログイン'
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    within '#session' do
      click_on 'ログイン'
    end
  end
end

RSpec.configure do |config|
  config.include LoginSupport
end