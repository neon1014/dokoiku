class DokoikuController < ApplicationController

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


    @stations = Stations.all

    #randの範囲で動作することを確認済
    @random_id = Random.rand(2..@stations.count+1)

    #デバッグ用関数
    _check_value_range(@stations.count)

    @doko = Stations.find_by(id: @random_id)

    #render text: @random
  end

end
