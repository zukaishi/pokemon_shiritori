# utils/mode.rb
def modeSelect(opt)
    # モードを決定
    shirotori_mode = true
    search_pos = 0
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
    return shirotori_mode,search_pos
end