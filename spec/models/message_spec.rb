require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @message = FactoryBot.build(:message)
  end

  describe '商品コメント' do
    context '商品コメントできる時' do
      it 'すべてが存在すればコメントできる' do
        expect(@message).to be_valid
      end
    end
    context '商品コメントできない時' do
      it 'contentが空だとコメントできない' do
        @message.content = ''
        @message.valid?
        expect(@message.errors.full_messages).to include('Contentを入力してください')
      end
      it 'usetが紐づいていなければコメントできない' do
        @message.user = nil
        @message.valid?
        expect(@message.errors.full_messages).to include('Userを入力してください')
      end
      it 'itemが紐づいていなければコメントできない' do
        @message.item = nil
        @message.valid?
        expect(@message.errors.full_messages).to include('Itemを入力してください')
      end
    end
  end
end
