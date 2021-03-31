require 'rails_helper'

RSpec.describe OrderShippingAddress, type: :model do
  before do
    @item = FactoryBot.build(:item)
    @user = FactoryBot.build(:user)
    @order_shipping_address = FactoryBot.build(:order_shipping_address, item_id: @item.id, user_id: @user.id )
  end

  describe '商品購入' do
    context '商品購入できる時' do
      it 'すべての値が正しく入力されていれば購入できる' do
        expect(@order_shipping_address).to be_valid
      end
      it 'prefecture_idが1でなければ購入できる' do
        @order_shipping_address.prefecture_id = 2
        expect(@order_shipping_address).to be_valid
      end
      it 'buildingは空でも購入できること' do
        @order_shipping_address.building = ''
        expect(@order_shipping_address).to be_valid
      end
    end

    context '商品購入できない時' do
      it 'tokenが空だと購入できない' do
        @order_shipping_address.token = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Token can't be blank")
      end
      it 'zip_codeが空だと購入できない' do
        @order_shipping_address.zip_code = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Zip code can't be blank")
      end
      it 'prefecture_idが空だと購入できない' do
        @order_shipping_address.prefecture_id = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空だと購入できない' do
        @order_shipping_address.city = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("City can't be blank")
      end
      it 'addressが空だと購入できない' do
        @order_shipping_address.address = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Address can't be blank")
      end
      it 'phone_numberが空だと購入できない' do
        @order_shipping_address.phone_number = ''
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'zip_codeが半角のハイフンを含んだ正しい形式でないと購入できない' do
        @order_shipping_address.zip_code = '1234567'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Zip code is invalid. Include hyphen(-)")
      end
      it 'prefectureを選択していないと購入できない' do
        @order_shipping_address.prefecture_id = 1
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Prefecture must be other than 1")
      end
      it 'phone_numberが12桁以上だと購入できない' do
        @order_shipping_address.phone_number = '012345678901'
        @order_shipping_address.valid?
        expect(@order_shipping_address.errors.full_messages).to include("Phone number is too long (maximum is 11 characters)")
      end
    end
  end
end