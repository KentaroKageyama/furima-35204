class ShippingAddress < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  
  belongs_to :order

  validates :prefecture_id, numericality: { other_than: 1 } 
end
