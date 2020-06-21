require 'uri'
require 'open-uri'
require 'nokogiri'
require 'json'

# wikiからポケモン一覧を取得する
DATA_URL="https://wiki.xn--rckteqa2e.com/wiki/%E3%83%9D%E3%82%B1%E3%83%A2%E3%83%B3%E4%B8%80%E8%A6%A7"
html = URI.open(DATA_URL).read
doc = Nokogiri::HTML.parse(html)
pokemon_list = doc.css('.mw-parser-output table.sortable tbody tr td:nth-child(2)>a').map(&:content)

# ンで終わるポケモンを除外する
pokemon_list = pokemon_list.reject {|v| v[-1] == "ン"}

# Todo 一行で完了させる
pokemon_list.map!{|x| x.rindex("♂")? x.gsub("♂","オス") : x}
pokemon_list.map!{|x| x.rindex("♀")? x.gsub("♀","メス") : x}
# 捨て仮名を普通のカタカナ変換
pokemon_list.map!{|x| x.rindex("ァ")? x.gsub("ァ","ア") : x}
pokemon_list.map!{|x| x.rindex("ィ")? x.gsub("ィ","イ") : x}
pokemon_list.map!{|x| x.rindex("ゥ")? x.gsub("ゥ","ウ") : x}
pokemon_list.map!{|x| x.rindex("ェ")? x.gsub("ェ","エ") : x}
pokemon_list.map!{|x| x.rindex("ォ")? x.gsub("ォ","オ") : x}
#puts JSON.pretty_generate(pokemon_list.uniq)

# 開始、終了となるポケモンの名前を受け取る
puts "ポケモン２匹を半角スペース区切りで入力してください"
pokemons = gets.split(' ')
# 入力されたポケモンが存在するか
if !pokemon_list.rindex( pokemons[0] ) or !pokemon_list.rindex( pokemons[1] ) then
  p exit
end
start_p = pokemons[0]
end_p = pokemons[1]

# 開始、終了のポケモンを除外する
pokemon_list = pokemon_list.reject {|v| v == start_p}
pokemon_list = pokemon_list.reject {|v| v == end_p}

target_p = start_p
puts target_p

# しりとり開始
for i in 0...10
  # 最後の伸ばし棒が最後にある場合一つ前の文字を最後の文字とする
  last_str =  target_p[-1]
  if last_str == "ー"
    last_str =  target_p[-2]
  end

  # 全体のリストから最初の文字が対象の最後の文字と一致するものを探し出してリストを作る
  pokemon_list2 = pokemon_list.reject {|v| v[0] != last_str}
  count = pokemon_list2.count
  if count == 0
    puts "test2"
    break
  end

  puts JSON.pretty_generate(pokemon_list2.uniq)
  # ターゲットを決める
  target_p = pokemon_list2[rand(0...count)]

  # 対象となったポケモンを大元のリストから除外する
  pokemon_list = pokemon_list.reject {|v| v == target_p}
  puts target_p

  # 終了ポケモンの最初の文字と、最後の文字が一致してた場合しりとり終了
  if end_p[0] == last_str
    puts "end"
    break;
  end
end

# Todo　終了ポケモンになったら、そのパターンを保持する
# Todo パターンを変えて、再度検索を行い、保持していたパターンより数が少なければ置き換え
# Todo もっとも最短となるパターンが残るはずなので、そのパターンを配列を表示して完了
