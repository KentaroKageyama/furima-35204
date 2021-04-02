require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context 'ユーザー新規登録できる時' do
      it 'nickname, email、password, password_confirmation, first_name, last_name, first_name_kana, last_name_kana, birthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordとpassword_confirmationが6文字以上で半角英数字が混合されていれば登録できる' do
        @user.password = 'abc456'
        @user.password_confirmation = @user.password
        expect(@user).to be_valid
      end
      it 'first_name, last_nameが全角（漢字・ひらがな・カタカナ）であれば登録できる' do
        @user.first_name = '阿あア'
        @user.last_name = '為いイ'
        expect(@user).to be_valid
      end
      it 'first_name_kana, last_name_kanaが全角（カタカナ）であれば登録できる' do
        @user.first_name = 'アイウエオ'
        @user.last_name = 'カキクケコ'
        expect(@user).to be_valid
      end
    end

    context 'ユーザー新規登録できない時' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名を入力してください")
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("姓を入力してください")
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名(フリガナ)を入力してください")
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("姓(フリガナ)を入力してください")
      end
      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'emailが@を含んでいなければ登録できない' do
        @user.email = 'abcdefg.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = 'abc45'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'passwordが数字だけでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは英字と数字の両方を含めて設定してください')
      end
      it 'passwordが英字だけでは登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは英字と数字の両方を含めて設定してください')
      end
      it 'passwordが全角では登録できない' do
        @user.password = 'あいうえお'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは英字と数字の両方を含めて設定してください')
      end
      it 'first_nameが全角（漢字・ひらがな・カタカナ）でなけれは登録できない' do
        @user.first_name = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('名は全角(漢字・ひらがな・カタカナ)で入力してください')
      end
      it 'last_nameが全角（漢字・ひらがな・カタカナ）でなけれは登録できない' do
        @user.last_name = 'aaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('姓は全角(漢字・ひらがな・カタカナ)で入力してください')
      end
      it 'first_name_kanaが全角（カタカナ）でなけれは登録できない' do
        @user.first_name_kana = 'あああああ'
        @user.valid?
        expect(@user.errors.full_messages).to include('名(フリガナ)は全角(カタカナ)で入力してください')
      end
      it 'last_name_kanaが全角（カタカナ）でなけれは登録できない' do
        @user.last_name_kana = 'あああああ'
        @user.valid?
        expect(@user.errors.full_messages).to include('姓(フリガナ)は全角(カタカナ)で入力してください')
      end
    end
  end
end














