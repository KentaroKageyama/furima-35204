class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :shipping_add
  belongs_to :shipping_day

  validates :images, presence: { message: 'を添付してください' }
  with_options presence: true do
    validates :name, :description
    with_options numericality: { other_than: 1, message: 'を選択してください' } do
      validates :category_id, :condition_id, :shipping_fee_id, :shipping_add_id, :shipping_day_id
    end
    validates :price, inclusion: { in: 300..9_999_999, message: 'は300~9,999,999の間で入力してください' },
                      numericality: true
  end

  has_many_attached :images

  belongs_to :user
  has_one :order
  has_many :messages, dependent: :destroy
  has_many :favorites
end
