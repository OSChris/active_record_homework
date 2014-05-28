class User < ActiveRecord::Base

  before_save :sanitize_names

  # scope: :full_search, lambda { |search_item| where(["first_name LIKE ? OR last_name LIKE ? OR email LIKE ?", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%"]) }
  # scope: :date_range, -> { |date1, date2| where(["created_at > ?", date1]).where("created_at < ?", date2) }
  # scope: :exact_search, -> { |search_item| where(["first_name LIKE ? OR last_name LIKE ? OR email LIKE ?", search_item, search_item, search_item]) }
  scope :created_after, lambda { |t| where(["created_at > ?", t]) }

# Finds all users between range date1 and date 2
  def self.date_range(date1, date2)
    where(["created_at > ?", date1]).where("created_at < ?", date2) 
    ### Example date1 = 3.days.ago & date2 = 2.days.ago
    ### date1 = 30.minutes.ago & date2 = 10.minutes.ago
  end

# Full text search to find any user with a first, last name or email containing search_item
  def self.full_search(search_item)
    where(["first_name LIKE ? OR last_name LIKE ? OR email LIKE ?", 
      "%#{search_item}%", "%#{search_item}%", "%#{search_item}%"])
  end

# Full text search to find any user with a first, last name or email exactly matching search_item
  def self.exact_search(search_item)
    where(["first_name LIKE ? OR last_name LIKE ? OR email LIKE ?",
           search_item, search_item, search_item])
  end

# Finds all users without 'john' in either their first or last name
  def self.not_john
    where.not(["first_name LIKE ? OR first_name LIKE ?", "john", "John"])
    .where.not(["last_name LIKE ? OR last_name LIKE ?", "john", "John"])
  end

private

# Removes extra spaces and capitalizes first and last name
  def sanitize_names
    self.first_name = first_name.squeeze(" ").strip.capitalize
    self.last_name = last_name.squeeze(" ").strip.capitalize
  end

end
