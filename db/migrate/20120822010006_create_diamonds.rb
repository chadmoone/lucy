class CreateDiamonds < ActiveRecord::Migration
  def change
    create_table :diamonds do |t|
      t.string :bn_number
      t.string :gia_number
      t.decimal :carat_weight
      t.string :color
      t.string :clarity
      t.string :cut_grade
      t.decimal :height_mm
      t.decimal :diameter_max
      t.decimal :diameter_min
      t.decimal :table_size
      t.decimal :total_depth
      t.decimal :crown_angle
      t.decimal :crown_height
      t.decimal :pavillion_angle
      t.decimal :pavillion_depth
      t.decimal :star_length
      t.decimal :lower_half_length
      t.string :girdle_min
      t.string :girdle_max
      t.string :cutlet_size
      t.string :polish
      t.string :symmetry
      t.string :flourescence
      t.decimal :hca_score
      t.string :aga_naja_grade
      t.integer :ship_time

      t.timestamps
    end
  end
end
