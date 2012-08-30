require 'rubygems'
require 'restclient'
require 'nokogiri'


namespace :aja do

  desc 'Load AJA/NAJA scores for all diamonds without one.'
  task :load_missing => :environment do

    puts "Loading missing AJA/NAJA scores..."

    url = "http://www.pricescope.com/tools/AGA_NAJA_Cut_Class_Grader"

    diamonds = Diamond.all

    diamonds.each do |diamond|
      if diamond.aja_score.nil? && diamond.gia_number
        puts "loading aja for diamond #{diamond.bn_number}"
        
        girdle_index = ["",
                        "Extremely Thin",
                        "Very Thin",
                        "Thin",
                        "Slightly Thin",
                        "Medium",
                        "Slightly Thick",
                        "Thick",
                        "Very Thick",
                        "Extremely Thick"]
        
        # cleanup...
        diamond.girdle_min = diamond.girdle_min.gsub(/( $|^ )/, '')
        diamond.girdle_max = diamond.girdle_max.gsub(/( $|^ )/, '')
        
        params = {"opt_shape" => "8",
                  "input_L" => diamond.diameter_max.to_s,
                  "input_W" => diamond.diameter_min.to_s,
                  "input_D" => diamond.height_mm.to_s,
                  "input_tab_percent" => diamond.table_size.to_s,
                  "input_crown_h" => diamond.crown_height.to_s,
                  "opt_girdle_from" => girdle_index.index(diamond.girdle_min),
                  "opt_girdle_to" => girdle_index.index(diamond.girdle_max),
                  "input_crown_angle" => diamond.crown_angle.to_s,
                  "input_pavilion_depth" => diamond.pavillion_depth.to_s,
                  "opt_polish" => "4",
                  "opt_symmetry" => "4",
                  "form_id" => "wc_stones",
                  "submit" => "Calculate AGA Cut Class"
                  }
        
        begin
          page = RestClient.post(url, params)
          npage = Nokogiri::HTML(page)
          results = npage.css("div#result_container ul#list_results li")
          
          a = {:tab_percent => results[0].text.gsub(/[\w ]*: /, ''),
               :crown_angle => results[1].text.gsub(/[\w ]*: /, ''),
               :crown_height => results[2].text.gsub(/[\w ]*: /, ''),
               :pavilion_depth => results[3].text.gsub(/[\w ]*: /, ''),
               :girdle => results[4].text.gsub(/[\w ]*: /, ''),
               :depth => results[5].text.gsub(/[\w ]*: /, ''),
               :polish => results[6].text.gsub(/[\w ]*: /, ''),
               :symmetry => results[7].text.gsub(/[\w ]*: /, ''),
               :total_grade => results[8].text.gsub(/[\w ]*: /, '')
               }
        
        aja =  AjaScore.create(a)
        aja.diamond = diamond
        aja.save
          
        rescue Exception => e
          puts "  --error updating diamond #{diamond.bn_number}"
          puts "  --params: #{params}"
          puts e
          
        end

        
      end
    end
  end
end