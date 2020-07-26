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

  # しりとり開始
  shiritori(pokemon_list,pokemons[0],pokemons[1])
else
  # 検索モード
  p "検索したい最初の文字を１文字入力してください"
  serach_word = STDIN.gets

  # 全体のリストから最初の文字が対象の最後の文字と一致するものを探し出してリストを作る
  pokemon_list = pokemon_list.reject {|v| v[search_pos] != serach_word.chomp}
  p pokemon_list.uniq
end
