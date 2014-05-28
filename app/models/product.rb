class Product < ActiveRecord::Base
#validates that the name parameter is present, unique, and doesn't contain the reserved words
  validates :name, presence: true, uniqueness: true, exclusion: { in: %w(Apple Microsoft Sony)}
#validates that the price is a number thats between 0 and 1000
  validates :price, numericality: { only_integer: true, greater_than: 0, less_than: 1000 }

  scope :grab_new_products, lambda { where(["updated_at > ?", 60.minutes.ago]) }

  validate :sale_price_cannot_be_higher_than_price

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

  def sale_price_cannot_be_higher_than_price
    self.sale_price ||= self.price
    if self.sale_price > self.price
      errors.add(:sale_price, "can't be higher than price.")
    end
  end

end
