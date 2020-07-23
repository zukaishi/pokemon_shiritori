# Todo 関数分けする
# Todo　終了ポケモンになったら、そのパターンを保持する
# Todo パターンを変えて、再度検索を行い、保持していたパターンより数が少なければ置き換え
# Todo もっとも最短となるパターンが残るはずなので、そのパターンを配列を表示して完了
# Todo 処理の共通化
require 'json'
require 'optparse'
require './utils/help'
require './utils/mode'
require './utils/pokemon_list'

opt = OptionParser.new
optHelp(opt)
shirotori_mode, search_pos = modeSelect(opt)
pokemon_list = pokemon_list(shirotori_mode)

if shirotori_mode 
  # しりとりモード
  # 開始、終了となるポケモンの名前を受け取る
  puts "ポケモン２匹を半角スペース区切りで入力してください"
  pokemons = STDIN.gets.split(' ')

  # 入力されたポケモンが存在するか
  if !pokemon_list.rindex( pokemons[0] ) or !pokemon_list.rindex( pokemons[1] ) then
    p exit
  end
  start_p = pokemons[0]
  end_p = pokemons[1]

  {"♂"=>"オス","♀"=>"メス","ァ"=>"ア","ィ"=>"イ","ゥ"=>"ウ","ェ"=>"エ","ォ"=>"オ","ュ"=>"ユ","ャ"=>"ヤ","ョ"=>"ヨ"}.each do | key, value|
    pokemon_list.map!{|x| x.rindex( key )? x.gsub(key,value ) : x}
  end
  # puts JSON.pretty_generate(pokemon_list.uniq)

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
      puts "end"
      break;
    end
  end
else
  # 検索モード
  puts "検索したい最初の文字を１文字入力してください"
  serach_word = STDIN.gets
  p serach_word
  p search_pos

  # 全体のリストから最初の文字が対象の最後の文字と一致するものを探し出してリストを作る
  pokemon_list2 = pokemon_list.reject {|v| v[search_pos] != serach_word.chomp}
  puts JSON.pretty_generate(pokemon_list2.uniq)
end

