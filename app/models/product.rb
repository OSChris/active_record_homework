class Product < ActiveRecord::Base

  validates :name, presence: true
  validates :price, numericality: { only_integer: true, greater_than: 0, less_than: 1000 }

  scope :grab_new_products, lambda { where(["updated_at > ?", 60.minutes.ago]) }

  before_destroy :destroy_logger 

  def self.between_one_and_three_hundred
    where(["price > 100"]).where(["price < 300"])
  end

  def self.on_sale
    grab_new_products.where.not(["price = sale_price"]).order("sale_price ASC").limit(3)
  end

private
  
  def destroy_logger
    logger.info "#{self} is about to be deleted."
  end

end
