class Product < ActiveRecord::Base

def self.between_one_and_three_hundred
  where(["price > 100"]).where(["price < 300"])
end

end
