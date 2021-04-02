require 'rails_helper'

RSpec.describe OrderShippingAddress, type: :model do
  before do
    @item = FactoryBot.create(:item)
    @user = FactoryBot.create(:user)
    @order_shipping_address = FactoryBot.build(:order_shipping_address, item_id: @item.id, user_id: @user.id)
    sleep 0.1
  end

  describe '商品購入' do
    context '商品購入できる時' do
      it 'すべての値が正しく入力されていれば購入できる' do
        expect(@order_shipping_address).to be_valid
      end
      it 'zip_codeが3桁の数字-4桁の数字であれば購入できる' do
        @order_shipping_address.zip_code = '123-4567'
        expect(@order_shipping_address).to be_valid
      end
      it 'prefecture_idが1でなければ購入できる' do
        @order_shipping_address.prefecture_id = 2
        expect(@order_shipping_address).to be_valid
      end
      it 'buildingは空でも購入できる' do
        @order_shipping_address.building = ''
        expect(@order_shipping_address).to be_valid
      end
      it 'phone_numberが11桁以内の半角数字であれば購入できる' do
        @order_shipping_address.phone_number = '01234567890'
        expect(@order_shipping_address).to be_valid
      end
    end

    context '商品購入できない時' do
      it 'tokenが空だと購入できない' do
        @order_shipping_address.token = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("正しくクレジットカード情報を入力してください")
      end
      it 'zip_codeが空だと購入できない' do
        @order_shipping_address.zip_code = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("郵便番号を入力してください")
      end
      it 'prefecture_idが空だと購入できない' do
        @order_shipping_address.prefecture_id = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("都道府県を選択してください")
      end
      it 'cityが空だと購入できない' do
        @order_shipping_address.city = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("市区町村を入力してください")
      end
      it 'addressが空だと購入できない' do
        @order_shipping_address.address = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("番地を入力してください")
      end
      it 'phone_numberが空だと購入できない' do
        @order_shipping_address.phone_number = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("電話番号を入力してください")
      end
      it 'user_idが空だと購入できない' do
        @order_shipping_address.user_id = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Userを入力してください")
      end
      it 'item_idが空だと購入できない' do
        @order_shipping_address.item_id = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Itemを入力してください")
      end
      it 'zip_codeが半角のハイフンを含んだ正しい形式でないと購入できない' do
        @order_shipping_address.zip_code = '1234567'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('郵便番号はハイフン(-)を入れて、半角数字で入力してください')
      end
      it 'prefectureを選択していないと購入できない' do
        @order_shipping_address.prefecture_id = 1
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('都道府県を選択してください')
      end
      it 'phone_numberが12桁以上だと購入できない' do
        @order_shipping_address.phone_number = '012345678901'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('電話番号は11文字以内で入力してください')
      end
      it 'phone_numberが半角英字では購入できない' do
        @order_shipping_address.phone_number = 'abcde'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('電話番号は半角数字のみで入力してください')
      end
      it 'phone_numberが全角数字では購入できない' do
        @order_shipping_address.phone_number = '１２３４５６７８９'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include('電話番号は半角数字のみで入力してください')
      end
    end
  end
end






