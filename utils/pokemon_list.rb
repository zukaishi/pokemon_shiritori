# utils/pokemon_list.rb
require 'uri'
require 'open-uri'
require 'nokogiri'

def pokemon_list()
    # ポケモン一覧を取得する
    pokemon_data_file = "./data/pokemon_list.csv"
    if File.exist?(pokemon_data_file)
        f = File.open(pokemon_data_file)
            html = f.read 
        f.close
    else
        html = URI.open("https://wiki.xn--rckteqa2e.com/wiki/%E3%83%9D%E3%82%B1%E3%83%A2%E3%83%B3%E4%B8%80%E8%A6%A7").read
        File.open(pokemon_data_file, mode = "w"){|f|
            f.write(html)
        }
    end
    doc = Nokogiri::HTML.parse(html)
    return doc.css('.mw-parser-output table.sortable tbody tr td:nth-child(2)>a').map(&:content)
end