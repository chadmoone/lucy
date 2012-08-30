
namespace :bluenile do
  desc 'Check bluenile.com for updates in diamond search.'
  task :refresh => :environment do
    puts "Updating diamonds from bluenile.com..."
    
    starttime = Time.now.utc
    @new = []
    @updated = []
    @new_archived = []
    
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
      
      unless diamond.current_price && diamond.current_price.price == price 
        old_price = diamond.current_price
        price_snapshot = PriceSnapshot.create({:price => price, :diamond => diamond})
        diamond.current_price = price_snapshot
        puts "updating price..."
        puts "updated price for diamond #{diamond.bn_number} from #{old_price ? old_price.price : 0.00} to #{price_snapshot.price}"
        @updated << diamond
      end
      
      diamond.save
      
    end
    
    @missing = Diamond.where("updated_at < ? AND archived = ?", starttime, false)
    @missing.each do |missing_d|
      puts "handling missing diamond..."
      page = Nokogiri::HTML(open("http://www.bluenile.com/diamond-details-panel?pid=#{missing_d.bn_number}")) 
      missing_price = page.css('div.details_column')[1].css('td')[3].text.gsub(/[\D]/, '').to_f
      available = page.css('div.shipping p').text != "Not Available For Purchase."
      
      if available
        puts "Diamond #{missing_d.bn_number} was missing, but still available"
        if !missing_d.current_price || missing_d.current_price.price != missing_price 
          old_price = missing_d.current_price
          price_snapshot = PriceSnapshot.create({:price => missing_price, :diamond => missing_d})
          missing_d.current_price = price_snapshot
          puts "updated price for diamond #{missing_d.bn_number} from #{old_price.price} to #{price_snapshot.price}"
          @updated << missing_d
        end
      else
        missing_d.archived = true
        @new_archived << missing_d
        puts "Diamond #{missing_d.bn_number} no longer available, archiving"
      end
      missing_d.save
    end
    
    @current = Diamond.where('updated_at >= ?', starttime)
    @archived = Diamond.where('archived = ?', true)
    
    @archived.each do |archive_d|
      
    end
    
    puts "Finished bluenile.com refresh:"
    puts "    #{@new.count} new diamonds"
    puts "    #{@updated.count} updated diamonds"
    puts "    #{@new_archived.count} just archived diamonds"
    puts "    #{@current.count} available diamonds"
    puts "    #{@archived.count} archived diamonds"
  end
  
  
  task :dates => :environment do
    date1 = "Friday, September 7"
    puts DateTime.strptime(date1, '%A, %B %e')
    
  end
  
  task :update_all => :environment do
    
    @all_diamonds = Diamond.all()
    @updated = []
    @archived = []
    @new_archived = []
    
    @all_diamonds.each do |diamond|
      puts "loading diamond #{diamond.bn_number}..."
      BN_URL = "http://www.bluenile.com/diamond-details-panel?pid=#{diamond.bn_number}"
      page = Nokogiri::HTML(open(BN_URL))
        
      current_price = page.css('div.details_column')[1].css('td')[3].text.gsub(/[\D]/, '').to_f
      availability_text = page.css('div.shipping p').text
      available = availability_text !~ /Not Available For Purchase/ && availability_text !~ /Call [\d-]* for current availability/
      
      # puts "available - #{available}"
      
      if available
        if !diamond.current_price || diamond.current_price.price != current_price 
          old_price = diamond.current_price
          price_snapshot = PriceSnapshot.create({:price => current_price, :diamond => diamond})
          diamond.current_price = price_snapshot
          puts "  ...updated price for diamond #{diamond.bn_number} from #{old_price.price} to #{price_snapshot.price}"
          @updated << diamond
        end
      else
        diamond.archived = true
        @new_archived << diamond
        puts "  ...Diamond #{diamond.bn_number} no longer available, archiving"
      end
      
      ship_time = nil
      
      unless diamond.archived == true
        
        begin
          shipping_parse = /([\w]*, [\w]* [\d]*)(?= when \tset in jewelry)/.match(page.css('div.shipping p').text)
          # puts "Date: #{Regexp.last_match.to_s}"
          ship_date = DateTime.strptime(Regexp.last_match.to_s, '%A, %B %e')
          # puts "Ship date: #{ship_date}"
          # puts "Today: #{Date.today}"
          ship_time = Date.today.business_days_until(ship_date)
          # puts "Days: #{ship_time}"
          
        rescue Exception => e
          puts "  --failed loading date from http://www.bluenile.com/diamond-details-panel?pid=#{diamond.bn_number}"
          puts "  --available: #{available}"
          puts "  --#{page.css('div.shipping p').text}"
          puts "  --#{e}"
        end
      end
      
      # Table cells that contain the rest of the diamond info
      cells = page.css('div.details_column')[1].css('td')
      
      measurments = cells[31].text
      measure_parse = /(?<dia1>[\d\/.]+) x (?<dia2>[\d\/.]+) x (?<depth>[\d\/.]+)/.match(measurments)
      diams = [measure_parse[:dia1].to_f, measure_parse[:dia2].to_f]
      diameter_min = diams.min.to_f
      diameter_max = diams.max.to_f
      height_mm = measure_parse[:depth].to_f
      
      d = {
        # :shape => r.css('div.shape span.a').text,
        :carat_weight => cells[9].text.to_f,
        :cut_grade => cells[11].text,
        :color => cells[13].text,
        :clarity => cells[15].text,
        :polish => cells[21].text,
        :symmetry => cells[23].text,
        :total_depth => cells[17].text.to_f,
        :table_size => cells[19].text.to_f,
        :flourescence => cells[29].text,
        :diameter_min => diameter_min,
        :diameter_max => diameter_max,
        :height_mm => height_mm,
        :ship_time => ship_time
        };
      
      # puts d.inspect
      
      diamond.update_attributes(d)
      diamond.save
      
    end
    
    
    
  end
    
end