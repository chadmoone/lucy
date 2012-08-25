
namespace :bluenile do
  desc 'Check bluenile.com for updates in diamond search.'
  task :refresh => :environment do
    puts "updating diamonds"
    
    starttime = Time.now.utc
    @new = []
    @updated = []
    
    page = Nokogiri::HTML(open("http://www.bluenile.com/diamond-search/grid.html?currency=USD&sortCol=carat&sortDir=asc&shape=RD&minCarat=0.97&maxCarat=10.00&minColor=I&maxColor=D&minPrice=1&maxPrice=6600&minCut=Ideal&maxCut=Signature+Ideal&minClarity=VS1&maxClarity=FL&minFluorescence=Faint&maxFluorescence=None&fluorescence=1&looseDate=false&type=SINGLE&startIndex=0&canvasScrollPosition=0&gridScrollPosition=0&showRowNumbers=false"))   
    
    rows = page.css('div.row')
    
    rows.each do |r|
    
      measurments = r.css('div.viewSelect div')[0]["measurements"]  
      measure_parse = /(?<dia1>[\d\/.]+)x(?<dia2>[\d\/.]+)x(?<depth>[\d\/.]+)/m.match(measurments)
      diams = [measure_parse[:dia1].to_f, measure_parse[:dia2].to_f]
      diameter_min = diams.min
      diameter_max = diams.max
      height_mm = measure_parse[:depth].to_f
      
      price = r.css('div.price').text.gsub(/[$,]/, '').to_f
      
      d = {:bn_number => r["data-sku"],
         # :shape => r.css('div.shape span.a').text,
         :carat_weight => r.css('div.carat').text.to_f,
         :cut_grade => r.css('div.cut span.a').text,
         :color => r.css('div.color').text,
         :clarity => r.css('div.clarity').text,
         :polish => r.css('div.polish').text,
         :symmetry => r.css('div.symmetry').text,
         :total_depth => r.css('div.depth').text.to_f,
         :table_size => r.css('div.table').text.to_f,
         :flourescence => r.css('div.fluor span.a').text,
         :diameter_min => diameter_min.to_f,
         :diameter_max => diameter_max.to_f,
         :height_mm => height_mm.to_f
         };
      
      diamond = Diamond.where({:bn_number => d[:bn_number]}).first
      
      if diamond
        diamond.update_attributes(d)
        diamond.touch
      else
        diamond = Diamond.create(d)
        @new << diamond
      end
      
      if !diamond.current_price || diamond.current_price.price != price 
        price_snapshot = PriceSnapshot.create({:price => price, :diamond => diamond})
        diamond.current_price = price_snapshot
        @updated << diamond
      end
      
      diamond.save
      
    end
    
    @missing = Diamond.where("updated_at < ? AND archived = ?", starttime, false)
    @missing.each do |missing_d|
      page = Nokogiri::HTML(open("http://www.bluenile.com/diamond-details-panel?pid=#{missing_d.bn_number}")) 
      missing_price = page.css('div.details_column')[1].css('td')[3].text.gsub(/[\D]/, '').to_f
      available = page.css('div.shipping p').text != "Not Available For Purchase."
      
      if available
        price_snapshot = PriceSnapshot.create({:price => missing_price, :diamond => missing_d})
      else
        missing_d.archived = true
      end
      missing_d.save
    end
    
    @current = Diamond.where('updated_at >= ?', starttime)
    @archived = Diamond.where('archived = ?', true)
    puts @current.to_yaml
  end
end