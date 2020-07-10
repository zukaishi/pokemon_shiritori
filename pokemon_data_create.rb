# how to use 
# しりとりモード
# ruby pokemon_data_create.rb 
# 検索モード
# ruby pokemon_data_create.rb -s

require 'uri'
require 'open-uri'
require 'nokogiri'
require 'json'
require 'optparse'

# wikiからポケモン一覧を取得する
DATA_URL="https://wiki.xn--rckteqa2e.com/wiki/%E3%83%9D%E3%82%B1%E3%83%A2%E3%83%B3%E4%B8%80%E8%A6%A7"
html = URI.open(DATA_URL).read
doc = Nokogiri::HTML.parse(html)
pokemon_list = doc.css('.mw-parser-output table.sortable tbody tr td:nth-child(2)>a').map(&:content)

shirotori_mode = true
search_pos = 0
opt = OptionParser.new
opt.on('-s', '--start', 'add an item') {
  puts '最初の文字検索モード'
  shirotori_mode = false
  search_pos = 0
}
opt.on('-e', '--end', 'add an item') {
  puts '最後の文字検索モード'
  shirotori_mode = false
  search_pos = -1
}
opt.parse(ARGV)

if shirotori_mode
  # しりとりモードならンで終わるポケモンを除外する
  pokemon_list = pokemon_list.reject {|v| v[-1] == "ン"}
end

str_map = { 
  "♂" => "オス","♀" => "メス","ァ" => "ア","ィ" => "イ","ゥ" => "ウ","ェ" => "エ","ォ" => "オ","ュ" => "ユ","ャ" => "ヤ","ョ" => "ヨ"
}
str_map.each do | key, value|
  pokemon_list.map!{|x| x.rindex( key )? x.gsub(key,value ) : x}
end
#puts JSON.pretty_generate(pokemon_list.uniq)

# 開始、終了となるポケモンの名前を受け取る
if shirotori_mode 
  puts "ポケモン２匹を半角スペース区切りで入力してください"
  pokemons = STDIN.gets.split(' ')
  # 入力されたポケモンが存在するか
  if !pokemon_list.rindex( pokemons[0] ) or !pokemon_list.rindex( pokemons[1] ) then
    p exit
  end
  start_p = pokemons[0]
  end_p = pokemons[1]

  # 開始、終了のポケモンを除外する
  pokemon_list = pokemon_list.reject {|v| v == start_p}
  pokemon_list = pokemon_list.reject {|v| v == end_p}

  # スタートポケモンを操作用の変数に格納
  target_p = start_p
  puts "start"

  # しりとり開始
  for i in 0...pokemon_list.count
    puts target_p

    # 最後の伸ばし棒が最後にある場合一つ前の文字を最後の文字とする
    last_str =  target_p[-1]
    if last_str == "ー"
      last_str =  target_p[-2]
    end

    # 全体のリストから最初の文字が対象の最後の文字と一致するものを探し出してリストを作る
    pokemon_list2 = pokemon_list.reject {|v| v[0] != last_str}
    count = pokemon_list2.count
    if count == 0
      puts "### しりとり負け ###"
      break
    end

    # 候補一覧を表示する
    #puts JSON.pretty_generate(pokemon_list2.uniq)
    # ターゲットを決める
    target_p = pokemon_list2[rand(0...count)]

    # 対象となったポケモンを大元のリストから除外する
    pokemon_list = pokemon_list.reject {|v| v == target_p}

    # 終了ポケモンの最初の文字と、最後の文字が一致してた場合しりとり終了
    if end_p[0] == last_str
      puts end_p
      # puts last_str
      puts "end"
      break;
    end
  end

  # Todo　終了ポケモンになったら、そのパターンを保持する
  # Todo パターンを変えて、再度検索を行い、保持していたパターンより数が少なければ置き換え
  # Todo もっとも最短となるパターンが残るはずなので、そのパターンを配列を表示して完了

else
  puts "検索したい最初の文字を１文字入力してください"
  serach_word = STDIN.gets
  p serach_word
  p search_pos

  # 全体のリストから最初の文字が対象の最後の文字と一致するものを探し出してリストを作る
  # Todo この部分は共通化できる
  pokemon_list2 = pokemon_list.reject {|v| v[search_pos] != serach_word.chomp}
  puts JSON.pretty_generate(pokemon_list2.uniq)
end