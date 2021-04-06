class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :password, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/, message: 'は英字と数字の両方を含めて設定してください' }

  with_options presence: true do
    validates :nickname
    with_options format: { with: /\A[ぁ-んァ-ン一-龥々ー]+\z/, message: 'は全角(漢字・ひらがな・カタカナ)で入力してください' } do
      validates :first_name
      validates :last_name
    end
    with_options format: { with: /\A[ァ-ヶー－]+\z/, message: 'は全角(カタカナ)で入力してください' } do
      validates :first_name_kana
      validates :last_name_kana
    end
    validates :birthday
  end

  has_many :items
  has_many :orders
  has_many :messages
  has_many :favorites
  has_many :favorite_items, through: :favorites, source: :item
  has_many :order_items, through: :orders, source: :item
end
