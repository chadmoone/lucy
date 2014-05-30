class PriceSnapshot < ActiveRecord::Base
  
  # attr_accessible :price, :diamond, :bn_id, :created_at
  belongs_to :diamond
  
  validates :diamond_id, :presence => true
  
  def bn_id=(bn_lookup)
    # logger.warn "WARNINGSSSSSS"
    if self.diamond.nil?
      self.diamond = Diamond.where({:bn_number => bn_lookup}).first
      # logger.info Diamond.where({:bn_number => bn_lookup}).first
      # logger.info self.diamond
    end
  end
  
  def bn_id
    if self.diamond
      self.diamond.bn_number
    end
  end
end
