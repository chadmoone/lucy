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
        
        bn_url = "http://www.bluenile.com/_#{diamond.bn_number}"
        
        begin
          puts "loading GIA data for #{diamond.bn_number}"
          bn_page = Nokogiri::HTML(open(bn_url))
          gia_text = bn_page.css('span.view_cert_text a')[1]["href"]
          gia_parse = /(?<=http:\/\/www.bluenile.com\/certs\/)(?<num>[0-9]{10})(?=\.pdf?)/.match(gia_text)
          gia_number = gia_parse[:num].to_i
        rescue 
          puts "Error GIA data from URL: #{bn_url}"
        else
          
          puts "...found GIA Number #{gia_number}"
          diamond.gia_number = gia_number
          
          if gia_number
            
            gia_url = "http://www.gia.edu/otmm_wcs_int/proxy-report/?ReportNumber=#{gia_number}&url=https://myapps.gia.edu/ReportCheckPOC/pocservlet?ReportNumber=#{gia_number}"
            begin
              puts "...loading additional GIA data: #{gia_url}"
              rc = RestClient.get(gia_url)
              rc = RestClient::Request.execute(:method => :get, :url => gia_url, :timeout => 60, :open_timeout => 100)
            rescue
              puts "Error loading URL: #{gia_url}"
            else
              page =  Nokogiri::XML(rc)
              
              diamond.crown_angle = page.css('CRN_AG').text.to_f
              diamond.crown_height = page.css('CRN_HT').text.to_f
              diamond.pavillion_angle = page.css('PAV_AG').text.to_f
              diamond.pavillion_depth = page.css('PAV_DP').text.to_f
              diamond.star_length = page.css('STR_LN').text.to_f
              diamond.lower_half_length = page.css('LR_HALF').text.to_f
              diamond.cutlet_size = page.css('CUTLET_SIZE').text
              
              if two_girdle_test = /(?<min>^[\w\s]*) to (?<max>[\w\s]*)/.match(page.css('GIRDLE').text)
                diamond.girdle_min = two_girdle_test[:min]
                diamond.girdle_max = two_girdle_test[:max]

              elsif one_girdle_test = /(?<min>^[\w\s]*)/.match(page.css('GIRDLE').text)
                diamond.girdle_min = one_girdle_test[:min]
                diamond.girdle_max = one_girdle_test[:min]
              
              else
                puts "--! no girdle matched"
              end
              
              puts "...saving GIA data."

              puts diamond.inspect
              diamond.save
            end # gia request
            
          end # if gia_number
        end # bn request
        
      end # if diamond.gia_number.nil?
    end # diamond loop
  end # task :load_missing
end # namespace :gia