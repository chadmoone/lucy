class HcaScore < ActiveRecord::Base
  attr_accessible :diamond, :fire, :light_return, :scintillation, :score, :spread
  
  belongs_to :diamond
  
  validates :diamond, :presence => true
  validates :score, :presence => true
end
