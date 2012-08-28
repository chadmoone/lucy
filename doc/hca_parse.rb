require 'rubygems'
require 'nokogiri'
require 'rest-client'
require 'open-uri'
require 'net/http'

params = {"depth_textbox" => "60",
          "table_textbox" => "57",
          "crown_listbox" => "0",
          "crown_textbox" => "34",
          "pavilion_listbox" => "0",
          "pavilion_textbox" => "40.5",
          "cutlet_textbox" => "0"
          }
headers = {:Host => 'www.pricescope.com',
           :'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:12.0) Gecko/20100101 Firefox/12.0',
           :accept => 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
           :'Accept-Language' => 'en-us,en;q=0.5',
           :'Accept-Encoding' => 'gzip, deflate',
           :Connection => 'keep-alive',
           :Referer => 'http://www.pricescope.com/tools/hca',
           :POSTDATA => 'POSTDATA=depth_textbox=60&table_textbox=57&crown_listbox=0&crown_textbox=34&pavilion_listbox=0&pavilion_textbox=40.5&cutlet_textbox=0'
          }

response = RestClient.post 'http://www.pricescope.com/tools/hca', { :params => params }
puts response
puts response.headers

# url = URI.parse('http://www.pricescope.com/tools/hca')
# resp, data = Net::HTTP.post_form(url, params)
# puts resp.inspect
# puts data.inspect