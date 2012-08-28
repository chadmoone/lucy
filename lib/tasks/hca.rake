require 'rubygems'
require 'restclient'
require 'nokogiri'


namespace :hca do
  
  desc 'Load HCA scores for all diamonds without one.'
  task :load_missing => :environment do
    
    puts "Loading mossing HCA scores..."
    
    url = "http://www.pricescope.com/tools/hca"
    
    diamonds = Diamond.all
    
    diamonds.each do |diamond|
      if diamond.hca_score.nil? && diamond.gia_number
        puts "loading hca for diamond #{diamond.bn_number}"
        
        params = {"depth_textbox" => diamond.total_depth.to_s,
                  "table_textbox" => diamond.table_size.to_s,
                  "crown_listbox" => "0",
                  "crown_textbox" => diamond.crown_angle.to_s,
                  "pavilion_listbox" => "0",
                  "pavilion_textbox" => diamond.pavillion_angle.to_s,
                  "cutlet_textbox" => "0"}
        
        puts params.inspect
        
        if page = RestClient.post(url, params)
          puts "Success getting html..."
        
          npage = Nokogiri::HTML(page)
        
          tds = npage.css('div.page table table td')
          
          hca = HcaScore.create(:diamond => diamond)
          hca.light_return = tds[5].text
          hca.fire = tds[7].text
          hca.scintillation = tds[9].text
          hca.spread = tds[11].text
          hca_string = tds[13].text
          score_parse = /^(?<score>[0-9]*\.[0-9]*)/.match(hca_string)
          hca.score = score_parse[:score].to_f
          
          hca.save
          
          puts "...saving HCA"
          # puts "Light Return: #{light_return}"
          # puts "Fire: #{fire}"
          # puts "Scintillation: #{scintillation}"
          # puts "Spread: #{spread}"
          # puts "Score: #{hca_score}"
        
        end
      end
    end
  end
end