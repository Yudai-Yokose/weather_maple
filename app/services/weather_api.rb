require 'httparty'

class WeatherApi
  include HTTParty
  base_uri 'https://api.openweathermap.org/data/2.5'

  def initialize(city_id)
    api_key = ENV['OPENWEATHERMAP_API_KEY']
    @options = { query: { id: city_id, appid: api_key, units: 'metric' } } #クエリパラメーター定義
  end

  def get_weather
    request = self.class.get("/weather", @options) #/weatherエンドポイントへhttpartyのgetリクエストを送信
    JSON.parse(request.body) #生のjsonデータをRuby形式のハッシュにする
  end

  def self.attributes_for(weather_data) #Ruby形式のハッシュからcontrollerに送る用のハッシュに変換
    sunrise_date = Time.at(weather_data.dig('sys', 'sunrise') || 0).in_time_zone('UTC').in_time_zone #Unixタイムスタンプを日付にしてJSTにする
    sunset_date = Time.at(weather_data.dig('sys', 'sunset') || 0).in_time_zone('UTC').in_time_zone

    {
      weather_id: weather_data.dig('weather', 0, 'id') || 0, #天気ID digでネストされたキーを探す。仮にキーが存在しなくても右辺代入するべし
      humidity: weather_data.dig('main', 'humidity') || 0, #湿度
      deg: weather_data.dig('wind', 'deg') || 0, #風向き
      pressure: weather_data.dig('main', 'pressure') || 0, #気圧
      visibility: weather_data.dig('visibility') || 0,  #視程
      temp_max: weather_data.dig('main', 'temp_max') || 0.0, #最高気温
      temp_min: weather_data.dig('main', 'temp_min') || 0.0, #最高気温
      temp_feel: weather_data.dig('main', 'feels_like') || 0.0, #体感
      speed: weather_data.dig('wind', 'speed') || 0.0, #風速
      sunrise_date: sunrise_date, #日の出の時間
      sunset_date: sunset_date, #日の入り
      main: weather_data.dig('weather', 0, 'main') || "不明", #天気の概要
      description: weather_data.dig('weather', 0, 'description') || "不明", #天気の詳細
      icon: weather_data.dig('weather', 0, 'icon') || "不明", #OpenWeathermapのアイコン
    }
  end
end
