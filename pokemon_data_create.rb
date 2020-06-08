require 'uri'
require 'open-uri'
require 'nokogiri'
require 'json'

# wikiからポケモン一覧を取得する
DATA_URL="https://wiki.xn--rckteqa2e.com/wiki/%E3%83%9D%E3%82%B1%E3%83%A2%E3%83%B3%E4%B8%80%E8%A6%A7"
html = URI.open(DATA_URL).read
doc = Nokogiri::HTML.parse(html)
pokemon_list = doc.css('.mw-parser-output table.sortable tbody tr td:nth-child(2)>a').map(&:content)

# Todo 一行で完了させる
pokemon_list.map!{|x| x.rindex("♂")? x.gsub("♂","オス") : x}
pokemon_list.map!{|x| x.rindex("♀")? x.gsub("♀","メス") : x}
# 捨て仮名を普通のカタカナ変換
pokemon_list.map!{|x| x.rindex("ァ")? x.gsub("ァ","ア") : x}
pokemon_list.map!{|x| x.rindex("ィ")? x.gsub("ィ","イ") : x}
pokemon_list.map!{|x| x.rindex("ゥ")? x.gsub("ゥ","ウ") : x}
pokemon_list.map!{|x| x.rindex("ェ")? x.gsub("ェ","エ") : x}
pokemon_list.map!{|x| x.rindex("ォ")? x.gsub("ォ","オ") : x}
puts JSON.pretty_generate(pokemon_list.uniq)
p pokemon_list

# 開始、終了となるポケモンの名前を受け取る
puts "ポケモン２匹を半角スペース区切りで入力してください"
pokemons = gets.split(' ')
# Todo 処理を綺麗にする
if !pokemon_list.rindex( pokemons[0] ) or !pokemon_list.rindex( pokemons[1] ) then
  p exit
end

# Todo 伸ばし棒は、棒の一つ前の文字を最後の文字として考える処理
# Todo ンで終わっているポケモンを除外する
# Todo 開始ポケモンの最後の文字を、最初とするポケモンを探し出す
# Todo これを終了ポケモンになるまで繰り返す
# Todo　終了ポケモンになったら、そのパターンを保持する
# Todo パターンを変えて、再度検索を行い、保持していたパターンより数が少なければ置き換え
# Todo もっとも最短となるパターンが残るはずなので、そのパターンを配列を表示して完了

=begin	
File.open("pokemon_names.json", mode = "w"){|f|
  f.write(list)
}
=end


