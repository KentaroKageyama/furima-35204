class Item < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :shipping_add
  belongs_to :shipping_day

  with_options presence: true do
    validates :name, :description, :user_id, :image
    with_options numericality: { other_than: 1 , message: "Select" } do
      validates :category_id, :condition_id, :shipping_fee_id, :shipping_add_id, :shipping_day_id
    end
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "Out of setting range" },
                      format: { with: /\A[0-9]+\z/ , message: "Half-width number"}
  end


  belongs_to :user
  has_one_attached :image

end
