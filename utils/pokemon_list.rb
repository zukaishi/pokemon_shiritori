# utils/pokemon_list.rb
require 'json'
require 'uri'
require 'open-uri'
require 'nokogiri'

def pokemon_list(shirotori_mode)
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
    pokemon_list =  doc.css('.mw-parser-output table.sortable tbody tr td:nth-child(2)>a').map(&:content)

    {"♂"=>"オス","♀"=>"メス","ァ"=>"ア","ィ"=>"イ","ゥ"=>"ウ","ェ"=>"エ","ォ"=>"オ","ュ"=>"ユ","ャ"=>"ヤ","ョ"=>"ヨ"}.each do | key, value|
        pokemon_list.map!{|x| x.rindex( key )? x.gsub(key,value ) : x}
    end
    if shirotori_mode
        # しりとりモードならンで終わるポケモンを除外する
        pokemon_list = pokemon_list.reject {|v| v[-1] == "ン"}
    end
    #puts JSON.pretty_generate(pokemon_list.uniq)
    return pokemon_list
end