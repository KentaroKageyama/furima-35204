require 'rails_helper'

RSpec.describe Favorite, type: :model do
  before do
    @favorite = FactoryBot.build(:favorite)
  end

  describe 'お気に入り登録' do
    context 'お気に入り登録できる時' do
      it 'UserとItemが紐づいていれば登録できる' do
        expect(@favorite).to be_valid
      end
    end
    context 'お気に入り登録できない時' do
      it 'userが紐づいていないと登録できない' do
        @favorite.user = nil
        @favorite.valid?
        expect(@favorite.errors.full_messages).to include('Userを入力してください')
      end
      it 'itemが紐づいていないと登録できない' do
        @favorite.item = nil
        @favorite.valid?
        expect(@favorite.errors.full_messages).to include('Itemを入力してください')
      end
    end
  end
end
