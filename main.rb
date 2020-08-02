require 'optparse'
require 'json'
require './utils/help'
require './utils/mode'
require './utils/pokemon_list'
require './utils/shiritori'
require './utils/sutegana'

opt = OptionParser.new
optHelp(opt)
shirotori_mode, search_pos = modeSelect(opt)
pokemon_list = pokemon_list(shirotori_mode)

if shirotori_mode 
  # 開始、終了となるポケモンの名前を受け取る
  p "ポケモン２匹を半角スペース区切りで入力してください"
  pokemons = STDIN.gets.split(' ')

  # 入力されたポケモンが存在するか
  for i in 0..1 do
    if !pokemon_list.rindex( pokemons[i] ) then
      p "#{i+1}個目に入力された#{pokemons[i]}は存在しません"
      exit
    end
    # 入力されたポケモンを除外する
    pokemon_list = pokemon_list.reject {|v| v == pokemons[i]}
  end

  # 捨て仮名（例えば、「ァ」なら、「ア」）を通常の大文字のカタカナに変換ししりとりで扱いやすくする
  pokemons = sutegana(pokemons)
  pokemon_list = sutegana(pokemon_list)

  # しりとりを件数分実行する
  try_count = 10
  for i in 0..try_count do
    p "start"
    result_list = shiritori(pokemon_list,pokemons[0],pokemons[1])
    p result_list
    p result_list.size
    p "end"
  end
else
  # 検索モード
  p "検索したい文字を入力してください"
  serach_word = STDIN.gets
  if search_pos == 0
    pokemon_list = pokemon_list.reject {|v|  v.index(serach_word.chomp) != 0}
  elsif search_pos == -1 
    length_end_pos =  serach_word.length-1
    pokemon_list = pokemon_list.reject {|v|  v.rindex(serach_word.chomp) != v.length-length_end_pos}
  elsif search_pos == 1 
    pokemon_list = pokemon_list.reject {|v|  v.include?(serach_word.chomp) != true}
  end
  p pokemon_list.uniq
end
