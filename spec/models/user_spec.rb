require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:alice) }
  let(:other_user) { FactoryBot.create(:bob) }

  describe 'ユーザーが無効な場合' do
    context 'ユーザー名が無効である事' do
      it 'ユーザー名が空である場合' do
        user.name = ' '
        expect(user.invalid?).to be_truthy
      end

      it 'ユーザー名が既に存在している場合' do
        user.name = other_user.name
        expect(user.invalid?).to be_truthy
      end
    end

    context 'アドレスが無効である事' do
      it 'アドレスが空である場合' do
        user.email = ' '
        expect(user.invalid?).to be_truthy
      end

      it 'アドレスがすでに存在している場合' do
        user.email = other_user.email
        expect(user.invalid?).to be_truthy
      end

      it '大文字と小文字を区別しない' do
        user.email = other_user.email.upcase
        expect(user.invalid?).to be_truthy
      end
    end

    context 'パスワードが無効である場合' do
      it 'パスワードが空である場合' do
        user.password = ' '
        expect(user.invalid?).to be_truthy
      end

      it 'パスワードが8文字以上である事' do
        user.password = 'a' * 7
        expect(user.invalid?).to be_truthy
      end
    end
  end

  it 'ダイジェストが存在しない場合、authenticated?はfalseを返す事' do
    user.save
    expect(user.authenticated?(' ')).to be_falsey
  end
end
