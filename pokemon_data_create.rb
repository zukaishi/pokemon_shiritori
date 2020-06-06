require 'uri'
require 'open-uri'
require 'nokogiri'
require 'json'

DATA_URL="https://wiki.xn--rckteqa2e.com/wiki/%E3%83%9D%E3%82%B1%E3%83%A2%E3%83%B3%E4%B8%80%E8%A6%A7"
html = URI.open(DATA_URL).read
doc = Nokogiri::HTML.parse(html)
list = doc.css('.mw-parser-output table.sortable tbody tr td:nth-child(2)>a').map(&:content)
puts JSON.pretty_generate(list.uniq)

	
File.open("pokemon_names.json", mode = "w"){|f|
  f.write(list)
}

