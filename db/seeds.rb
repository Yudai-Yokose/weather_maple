require 'json'

file_path = Rails.root.join('db', 'city_list', 'city_list.json')
data = JSON.parse(File.read(file_path))

data.each do |city|
  City.find_or_initialize_by(id: city["id"]).update!(
    name: city["name"],
    prefecture: city["prefecture"],
    region: city["region"],
    data_code: city["data_code"],
    openweathermap_city_code: city["openweathermap_city_code"]
  )
end

puts "#{data.size}件のデータを登録しました！"
