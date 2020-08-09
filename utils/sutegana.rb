# utils/sutegana.rb
def sutegana(list)
    {"♂"=>"オス","♀"=>"メス","ァ"=>"ア","ィ"=>"イ","ゥ"=>"ウ","ェ"=>"エ","ォ"=>"オ","ュ"=>"ユ","ャ"=>"ヤ","ョ"=>"ヨ"}.each do | key, value|
        if list[0] then
            list.map!{|x| x.rindex( key )? x.gsub(key,value ) : x}
        else
            list.map{|k,v| [k,v.gsub(key,value )] }.to_h
        end
    end
    return list
end