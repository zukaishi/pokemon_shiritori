require 'json'
require 'optparse'
require './utils/help'
require './utils/mode'
require './utils/pokemon_list'
require './utils/shiritori'

opt = OptionParser.new
optHelp(opt)
shirotori_mode, search_pos = modeSelect(opt)
pokemon_list = pokemon_list(shirotori_mode)

if shirotori_mode 
  # 開始、終了となるポケモンの名前を受け取る
  puts "ポケモン２匹を半角スペース区切りで入力してください"
  pokemons = STDIN.gets.split(' ')
  # 入力されたポケモンが存在するか
  if !pokemon_list.rindex( pokemons[0] ) or !pokemon_list.rindex( pokemons[1] ) then
    exit
  end
  # Todo　何度か実行を繰り返しもっとも最短でいけるパターンを最終回等とする
  shiritori(pokemon_list,pokemons[0],pokemons[1])
else
  # 検索モード
  puts "検索したい最初の文字を１文字入力してください"
  serach_word = STDIN.gets
  # 全体のリストから最初の文字が対象の最後の文字と一致するものを探し出してリストを作る
  pokemon_list2 = pokemon_list.reject {|v| v[search_pos] != serach_word.chomp}
  puts JSON.pretty_generate(pokemon_list2.uniq)
end
