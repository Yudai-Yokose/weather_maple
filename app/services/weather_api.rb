require 'httparty'

class WeatherApi
  include HTTParty
  base_uri 'https://api.openweathermap.org/data/2.5'

  def initialize(city_id)
    api_key = ENV['OPENWEATHERMAP_API_KEY']
    @options = { query: { id: city_id, appid: api_key, units: 'metric' } } #クエリパラメーター定義
  end

  def get_weather
    Rails.logger.info("APIをコールしました！")
    request = self.class.get("/weather", @options) #/weatherエンドポイントへhttpartyのgetリクエストを送信
    JSON.parse(request.body) #生のjsonデータをRuby形式のハッシュにする
  end

  def self.attributes_for(weather_data) #Ruby形式のハッシュからcontrollerに送る用のハッシュに変換
    sunrise_date = Time.at(weather_data['sys']['sunrise']).in_time_zone('UTC').in_time_zone #Unixタイムスタンプを日付にしてJSTにする
    sunset_date = Time.at(weather_data['sys']['sunset']).in_time_zone('UTC').in_time_zone

    {
      weather_id: weather_data['weather'][0]['id'], #天気ID
      humidity: weather_data['main']['humidity'], #湿度
      deg: weather_data['wind']['deg'], #風向き
      pressure: weather_data['main']['pressure'], #気圧
      visibility: weather_data['visibility'], #視程
      temp_max: weather_data['main']['temp_max'], #最高気温
      temp_min: weather_data['main']['temp_min'], #最適気温
      temp_feel: weather_data['main']['feels_like'], #体感
      speed: weather_data['wind']['speed'], #風速
      sunrise_date: sunrise_date, #日の出の時間
      sunset_date: sunset_date, #日の入り
      main: weather_data['weather'][0]['main'], #天気の概要
      description: weather_data['weather'][0]['description'], #天気の詳細
      icon: weather_data['weather'][0]['icon'], #OpenWeathermapのアイコン
    }
  end
end
