require 'rubygems'
require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(open("http://www.bluenile.com/diamond-search/grid.html?currency=USD&sortCol=price&sortDir=desc&builder=BYOR&shape=RD&minCarat=0.97&maxCarat=15.35&minColor=I&maxColor=D&minPrice=317&maxPrice=6600&minCut=Ideal&maxCut=Signature+Ideal&minClarity=VS1&maxClarity=FL&minFluorescence=Medium&maxFluorescence=None&fluorescence=1&looseDate=false&type=SINGLE&startIndex=0&canvasScrollPosition=0&gridScrollPosition=0&showRowNumbers=false&_=1345652430221"))   

# page = Nokogiri::HTML(open("BN Request"));
puts page.class   # => Nokogiri::HTML::Document

rows = page.css('div.row')

@diamonds = Array.new;

rows.each do |r|
  
  measurments = r.css('div.viewSelect div')[0]["measurements"]  

  measure_parse = /(?<dia1>[\d\/.]+)x(?<dia2>[\d\/.]+)x(?<depth>[\d\/.]+)/m.match(measurments)
  diams = [measure_parse[:dia1].to_f, measure_parse[:dia2].to_f]
  diameter_min = diams.min
  diameter_max = diams.max
  height_mm = measure_parse[:depth].to_f
  
  d = {:bn_id => r["data-sku"],
     # :shape => r.css('div.shape span.a').text,
     # :carat => r.css('div.carat').text.to_f,
     # :cut => r.css('div.cut span.a').text,
     # :color => r.css('div.color').text,
     # :clarity => r.css('div.clarity').text,
     # :polish => r.css('div.polish').text,
     # :symmetry => r.css('div.symmetry').text,
     # :depth => r.css('div.depth').text.to_f,
     # :table => r.css('div.table').text.to_f,
     # :fluorescense => r.css('div.fluor span.a').text,
     :price => r.css('div.price').text.gsub(/[$,]/, '').to_f
     # :diameter_min => diameter_min.to_f,
     # :diameter_max => diameter_max.to_f,
     # :height_mm => height_mm.to_f
     };
  
  @diamonds << d
  
  puts "#{d[:bn_id]}, #{d[:price]}"
  
end

puts @diamonds