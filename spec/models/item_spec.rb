require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品登録' do
    context '商品登録できる時' do
      it 'image, name, description, category_id, condition_id, shipping_fee_id, shipping_add_id, shipping_day_id, priceが存在すれば登録できる' do
        expect(@item).to be_valid
      end
      it 'category_id, condition_id, shipping_fee_id, shipping_add_id, shipping_day_idが1でなければ登録できる' do
        @item.category_id = 2
        @item.condition_id = 2
        @item.shipping_fee_id = 2
        @item.shipping_add_id = 2
        @item.shipping_day_id = 2
        expect(@item).to be_valid
      end
      it 'priceが300~9,999,999以内の半角数字であれば登録できる' do
        @item.price = 300
        expect(@item).to be_valid
      end
    end

    context '商品登録できない時' do
      it 'imageが空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を添付してください")
      end
      it 'nameが空では登録できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it 'descriptionが空では登録できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("説明文を入力してください")
      end
      it 'category_idが空では登録できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリを入力してください")
      end
      it 'condition_idが空では登録できない' do
        @item.condition_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を入力してください")
      end
      it 'shipping_fee_idが空では登録できない' do
        @item.shipping_fee_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を入力してください")
      end
      it 'shipping_add_idが空では登録できない' do
        @item.shipping_add_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を入力してください")
      end
      it 'shipping_day_idが空では登録できない' do
        @item.shipping_day_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を入力してください")
      end
      it 'priceが空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("価格を入力してください")
      end
      it 'userが紐づいていなければ登録できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Userを入力してください')
      end
      it 'category_idが1では登録できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリを選択してください')
      end
      it 'condition_idが1では登録できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態を選択してください')
      end
      it 'shipping_fee_idが1では登録できない' do
        @item.shipping_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担を選択してください')
      end
      it 'shipping_add_idが1では登録できない' do
        @item.shipping_add_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送元の地域を選択してください')
      end
      it 'shipping_day_idが1では登録できない' do
        @item.shipping_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数を選択してください')
      end
      it 'priceが299以下では登録できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は300~9,999,999の間で入力してください')
      end
      it 'priceが10000000以上では登録できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は300~9,999,999の間で入力してください')
      end
      it 'priceが全角文字では登録できない' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は数値で入力してください')
      end
      it 'priceが半角英数混合では登録できないこと' do
        @item.price = 'abc123'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は数値で入力してください')
      end
      it 'priceが半角英字だけでは登録できないこと' do
        @item.price = 'abcdef'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は数値で入力してください')
      end
    end
  end
end