class AddHitCounterToProduct < ActiveRecord::Migration
  def change
    add_column :products, :hit_count, :integer
  end
end
