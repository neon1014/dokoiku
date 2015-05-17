# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require "csv"

#初期データの読み込み
CSV.foreach('db/stationDB.csv') do |row|
  #DB名を指定？
  Station.create(:station_name => row[0], :address => row[1], :lat => row[2], :lon => row[3])
end
