# encoding : utf-8
class DokoikuController < ApplicationController
  require "openssl"
  require "base64"

  def index
    #nilだったらエラー（正しくDBから値が返ってきてない）
    def _index_test(_id)
      begin
      #明示的にint型にする必要がある
        id = _id.to_i
        data = Station.find_by(id: id)
        if data == nil then
          puts "id:"+id.to_s+" error"
        else
          puts "id:"+id.to_s+" OK"
        end
      rescue
        p "error"
      end
    end

    #Stationの範囲をチェックする
    def _check_value_range(max)
      _index_test(1)#=>NG
      _index_test(2)
      _index_test(3)
      _index_test(max-1)
      _index_test(max)
      _index_test(max+1)
      _index_test(max+2)#=>NG
      _index_test(max+3)#=>NG
    end

    #特定の文字列を表示する
    def _decrypt
      #暗号文読み込み
      f = File::open("./app/controllers/hoge.txt","rb")
      data = f.read
      f.close

      key = "hibike_euphonium"
      iv =  "_kyoto_animation"

      #複合化処理
      cipher = OpenSSL::Cipher.new('aes-128-cbc')
      cipher.decrypt
      cipher.key = key
      cipher.iv = iv

      #150607
      #wrong final block lengthが出てコンパイルできない
      #正常に複合ができていない？
      decrypted =  cipher.update(data) + cipher.final

      return decrypted.to_s
    end


    #150607
    #_decrypt関数が不具合のためコメントアウト
    #複合文格納
    #@decrypted = "!--"+_decrypt(data,key,iv).encode() + "--"

    #StationDBからの値を格納
    @stations = Stations.all

    #randの範囲で動作することを確認済
    @random_id = Random.rand(2..@stations.count+1)

    #デバッグ用関数
    #_check_value_range(@stations.count)

    @doko = Stations.find_by(id: @random_id)

    #render text: @random
  end

end
