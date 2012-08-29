require 'openssl'
require 'rest-client'
require 'nokogiri'
require 'open-uri'

namespace :gia do
  desc 'Check for diamonds missing GIA data and load it for them.'
  task :load_missing => :environment do
    puts "Updating diamond GIA data..."
    
    all_diamonds = Diamond.all
    
    all_diamonds.each do |diamond|
      if diamond.gia_number.nil?
        
        BN_URL = "http://www.bluenile.com/_#{diamond.bn_number}"
        
        begin
          puts "loading GIA data for #{diamond.bn_number}"
          bn_page = Nokogiri::HTML(open(BN_URL))
          gia_text = bn_page.css('span.view_cert_text a')[1]["href"]
          gia_parse = /(?<=http:\/\/www.bluenile.com\/certs\/)(?<num>[0-9]{10})(?=\.pdf?)/.match(gia_text)
          gia_number = gia_parse[:num].to_i
        rescue 
          puts "Error GIA data from URL: #{BN_URL}"
        else
          
          puts "...found GIA Number #{gia_number}"
          diamond.gia_number = gia_number
          
          if gia_number
            
            GIA_URL = "https://myapps.gia.edu/ReportCheckPortal/getReportData.do"
            begin
              puts "...loading additional GIA data..."
              rc = RestClient.get GIA_URL, :params => {"reportno" => "#{gia_number}", "weight" => "#{diamond.carat_weight}"}
            rescue
              puts "Error loading URL: #{GIA_URL}?reportno=#{gia_number}&weight=#{diamond.carat_weight}"
            else
              page =  Nokogiri::HTML(rc)
              
              proportions = page.css('table')[2].css('td')
              
              diamond.crown_angle = proportions[5].text.gsub(/[^\d\.]/, '').to_f
              diamond.crown_height = proportions[7].text.gsub(/[^\d\.]/, '').to_f
              diamond.pavillion_angle = proportions[9].text.gsub(/[^\d\.]/, '').to_f
              diamond.pavillion_depth = proportions[11].text.gsub(/[^\d\.]/, '').to_f
              diamond.star_length = proportions[13].text.gsub(/[^\d\.]/, '').to_f
              diamond.lower_half_length = proportions[15].text.gsub(/[^\d\.]/, '').to_f
              diamond.cutlet_size = proportions[19].text
              
              if two_girdle_test = /(?<min>^[\w\s]*) to (?<max>[\w\s]*)/.match(proportions[17].text)
                diamond.girdle_min = two_girdle_test[:min]
                diamond.girdle_max = two_girdle_test[:max]
                
              elsif one_girdle_test = /(?<min>^[\w\s]*)/.match(proportions[17].text)
                diamond.girdle_min = one_girdle_test[:min]
                diamond.girdle_max = one_girdle_test[:min]
                
              else
                puts "--! no girdle matched"
              end
              
              puts "...saving GIA data."
              diamond.save
              
              # puts "crown_angle: #{diamond.crown_angle}"
              # puts "crown_height: #{diamond.crown_height}"
              # puts "pavillion_angle: #{diamond.pavillion_angle}"
              # puts "pavillion_depth: #{diamond.pavillion_depth}"
              # puts "star_length: #{diamond.star_length}"
              # puts "lower_half_length: #{diamond.lower_half_length}"
              # puts "girdle_min: #{diamond.girdle_min}"
              # puts "girdle_max: #{diamond.girdle_max}"
              # puts "cutlet_size: #{diamond.cutlet_size}"
            end # gia request
            
          end # if gia_number
        end # bn request
        
      end # if diamond.gia_number.nil?
    end # diamond loop
  end # task :load_missing
end # namespace :gia