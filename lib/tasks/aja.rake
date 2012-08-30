require 'rubygems'
require 'restclient'
require 'nokogiri'


namespace :aja do

  desc 'Load AJA/NAJA scores for all diamonds without one.'
  task :load_missing => :environment do

    puts "Loading mossing AJA/NAJA scores..."

    url = "http://www.pricescope.com/tools/AGA_NAJA_Cut_Class_Grader"

    diamonds = [Diamond.last]

    diamonds.each do |diamond|
      if diamond.hca_score.nil? && diamond.gia_number
        puts "loading hca for diamond #{diamond.bn_number}"
        
        params = {"pt_shape" => "8",
                  "input_L" => "6.4",
                  "input_W" => "6.37",
                  "input_D" => "3.9",
                  "input_tab_percent" => "57",
                  "input_crown_h" => "15.5",
                  "opt_girdle_from" => "6",
                  "opt_girdle_to" => "6",
                  "input_crown_angle" => "15.5",
                  "input_pavilion_depth" => "43",
                  "opt_polish" => "4",
                  "opt_symmetry" => "4",
                  "form_id" => "wc_stones",
                  "submit" => "Calculate AGA Cut Class"
                  }

        puts params.inspect
        
        begin
          page = RestClient.post(url, params)
          puts "Success getting html..."
          
          npage = Nokogiri::HTML(page)
          
          puts npage
        rescue Exception => e
          puts e
        end

        
      end
    end
  end
end