class AddPricesToDiamonds < ActiveRecord::Migration
  def change
    add_column :diamonds, :current_price_id, :integer
    add_index :diamonds, :current_price_id
  end
end
