class AddShapeToDiamond < ActiveRecord::Migration
  def change
    add_column :diamonds, :shape, :string
  end
end
