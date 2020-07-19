# utils/help.rb
def optHelp(opt)
    opt.on('-h', '--help', 'add an item') {
      puts 'how to use '
      puts 'しりとりモード'
      puts 'ruby pokemon_data_create.rb '
      puts '検索モード 最初の文字 '
      puts 'ruby pokemon_data_create.rb -s'
      puts '検索モード 最後の文字 '
      puts 'ruby pokemon_data_create.rb -e'
      exit
    }
end
  