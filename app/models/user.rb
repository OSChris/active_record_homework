class User < ActiveRecord::Base

# scope: :full_search, lambda { |search_item| where(["first_name LIKE ? OR last_name LIKE ? OR email LIKE ?", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%"]) }
# scope: :date_range, -> { |date1, date2| where(["created_at > ?", date1]).where("created_at < ?", date2) }
# scope: :exact_search, -> { |search_item| where(["first_name LIKE ? OR last_name LIKE ? OR email LIKE ?", search_item, search_item, search_item]) }


def self.date_range(date1, date2)
  where(["created_at > ?", date1]).where("created_at < ?", date2) 
  ### Example date1 = 3.days.ago & date2 = 2.days.ago
  ### date1 = 30.minutes.ago & date2 = 10.minutes.ago
end

def self.full_search(search_item)
  where(["first_name LIKE ? OR last_name LIKE ? OR email LIKE ?", 
    "%#{search_item}%", "%#{search_item}%", "%#{search_item}%"])
end

def self.exact_search(search_item)
  where(["first_name LIKE ? OR last_name LIKE ? OR email LIKE ?",
         search_item, search_item, search_item])
end



end
