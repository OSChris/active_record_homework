class Product < ActiveRecord::Base

  scope :grab_new_products, lambda { where(["updated_at > ?", 60.minutes.ago]) }

  def self.between_one_and_three_hundred
    where(["price > 100"]).where(["price < 300"])
  end

  def self.on_sale
    grab_new_products.where.not(["price = sale_price"]).order("sale_price ASC").limit(3)
  end

end
