class CreatePriceSnapshots < ActiveRecord::Migration
  def change
    create_table :price_snapshots do |t|
      t.references :diamond
      t.decimal :price

      t.timestamps
    end
    add_index :price_snapshots, :diamond_id
  end
end
