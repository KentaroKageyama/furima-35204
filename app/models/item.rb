class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :shipping_add
  belongs_to :shipping_day

  with_options presence: true do
    validates :name, :description, :image
    with_options numericality: { other_than: 1, message: 'Select' } do
      validates :category_id, :condition_id, :shipping_fee_id, :shipping_add_id, :shipping_day_id
    end
    validates :price, inclusion: { in: 300..9_999_999, message: 'Out of setting range' },
                      numericality: true
  end

  belongs_to :user
  has_one_attached :image
  has_one :order
end
