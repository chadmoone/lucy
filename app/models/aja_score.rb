class AjaScore < ActiveRecord::Base
  belongs_to :diamond
  # attr_accessible :crown_angle, :crown_height, :depth, :girdle, :pavilion_depth, :polish, :symmetry, :tab_percent, :total_grade
end
