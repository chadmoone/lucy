class AddFavoriteToDiamonds < ActiveRecord::Migration
  def change
    add_column :diamonds, :favorite, :boolean
  end
end
