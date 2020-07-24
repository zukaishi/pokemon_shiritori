# utils/sutegana.rb
def sutegana(list)
    {"♂"=>"オス","♀"=>"メス","ァ"=>"ア","ィ"=>"イ","ゥ"=>"ウ","ェ"=>"エ","ォ"=>"オ","ュ"=>"ユ","ャ"=>"ヤ","ョ"=>"ヨ"}.each do | key, value|
        list.map!{|x| x.rindex( key )? x.gsub(key,value ) : x}
    end
    return list
end