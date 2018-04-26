class Order < ApplicationRecord
  belongs_to :user
  has_many :placements, dependent: :destroy
  has_many :products, through: :placements

  after_create :set_order_info!

  enum status: {
    in_progress: 0,
    done: 1,
    cancel_confirm: 5,
    cancelled: 6
  }

  def set_order_info!
    self.price = products.map(&:price).sum
    self.code = [format('%04d', self.id), self.user_id, Date.today.to_s.gsub(/\//, "")].join("-")
    self.in_progress!
    self.save
  end
end
