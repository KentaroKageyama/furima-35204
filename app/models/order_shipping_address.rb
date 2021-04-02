class OrderShippingAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :zip_code, :prefecture_id, :city, :address, :building, :phone_number, :token

  with_options presence: true do
    validates :token, :user_id, :item_id
    validates :zip_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/ , message: "はハイフン(-)を入れて、半角数字で入力してください"}
    validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }
    validates :city, :address
    validates :phone_number, format: { with: /\A[0-9]+\z/ , message: "は半角数字のみで入力してください"}, length: { maximum: 11 }
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(zip_code: zip_code, prefecture_id: prefecture_id, city: city, address: address, building: building,
                           phone_number: phone_number, order_id: order.id)
  end
end
