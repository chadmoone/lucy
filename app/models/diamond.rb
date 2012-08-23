class Diamond < ActiveRecord::Base
  attr_accessible :aga_naja_grade,
                  :bn_number,
                  :carat_weight,
                  :clarity,
                  :color,
                  :crown_angle,
                  :crown_height,
                  :cut_grade,
                  :cutlet_size,
                  :diameter_max,
                  :diameter_min,
                  :flourescence,
                  :gia_number,
                  :girdle_max,
                  :girdle_min,
                  :hca_score,
                  :height_mm,
                  :lower_half_length,
                  :pavillion_angle,
                  :pavillion_depth,
                  :polish,
                  :ship_time,
                  :star_length,
                  :symmetry,
                  :table_size,
                  :total_depth
  
  has_many :price_snapshots
  belongs_to  :current_price, :class_name => "PriceSnapshot"
  
end
