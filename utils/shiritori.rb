# utils/shiritori.rb
def shiritori(pokemon_list,start_p,end_p)  
    # スタートポケモンを操作用の変数に格納
    target_p = start_p
    p "start"

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
            p "### しりとり負け ###"
            break
        end

        # 候補一覧を表示する
        #p JSON.pretty_generate(pokemon_list2.uniq)
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
end