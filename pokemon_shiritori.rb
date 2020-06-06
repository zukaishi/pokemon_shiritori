#coding: utf-8

#-ライブラリの読み込み-#
require 'open-uri'
require 'nokogiri'
require 'kconv'
require "rubygems"
require "csv"


# スクレイピング先のURL
url = 'http://blog.game-de.com/pm-sm/sm-allstats/'
html = open(url, "r:binary").read
doc = Nokogiri::HTML(html.toutf8, nil, 'utf-8')
# タイトルを表示
p doc.title
CSV.open('pokemon_status.csv','w', :encoding => "SJIS") do |poke|
  #最初にヘッダー部分を直書き
  poke.puts(["図鑑番号","ポケモン名","タイプ１","タイプ２","通常特性１","通常特性２","夢特性","HP","こうげき","ぼうぎょ","とくこう","とくぼう","すばやさ","合計"])
  #ポケモンをステータスを1匹ずつ取得
  for i in 1..909 do
    if i % 100 == 0 then#進行状況の表示
      puts i.to_s + "/909"
    end
    path = '//*[@id="SortTable"]/tbody' + "/tr[#{i}]"
    status = load_data(doc,path)
    poke.puts(status)#読み込んだデータをcsvファイルに保存
  end
end

