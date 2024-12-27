require 'rails_helper'

RSpec.describe WeatherApi do
  describe ".get_weather" do
    let(:city_id) { 1850147 }
    let(:api_key) { "test_api_key" }
    let(:api_url) { "https://api.openweathermap.org/data/2.5/weather" }
    let(:mock_response) do
      {
        "coord" => { "lon" => 139.6917, "lat" => 35.6895 },
        "weather" => [
          {
            "id" => 801,
            "main" => "Clouds",
            "description" => "few clouds",
            "icon" => "02n"
          }
        ],
        "base" => "stations",
        "main" => {
          "temp" => 6.48,
          "feels_like" => 1.88,
          "temp_min" => 4.78,
          "temp_max" => 7.53,
          "pressure" => 1012,
          "humidity" => 43,
          "sea_level" => 1012,
          "grnd_level" => 1010
        },
        "visibility" => 10000,
        "wind" => {
          "speed" => 8.75,
          "deg" => 340
        },
        "clouds" => { "all" => 20 },
        "dt" => 1735295435,
        "sys" => {
          "type" => 2,
          "id" => 268395,
          "country" => "JP",
          "sunrise" => 1735249779,
          "sunset" => 1735284878
        },
        "timezone" => 32400,
        "id" => 1850147,
        "name" => "Tokyo",
        "cod" => 200
      }.to_json
    end

    before do # APIキーとリクエストをモック
      allow(ENV).to receive(:[]).with('OPENWEATHERMAP_API_KEY').and_return(api_key)

      stub_request(:get, api_url)
        .with(query: { id: city_id, appid: api_key, units: 'metric' })
        .to_return(status: 200, body: mock_response, headers: { 'Content-Type' => 'application/json' })
    end

    it "APIレスポンスを取得" do
      weather_api = WeatherApi.new(city_id)
      result = weather_api.get_weather

      expect(result["weather"][0]["id"]).to eq(801) # 天気ID
      expect(result["main"]["humidity"]).to eq(43) # 湿度
      expect(result["wind"]["deg"]).to eq(340) # 風向き
      expect(result["main"]["pressure"]).to eq(1012) # 気圧
      expect(result["visibility"]).to eq(10000) # 視程
      expect(result["main"]["temp_max"]).to eq(7.53) # 最高気温
      expect(result["main"]["temp_min"]).to eq(4.78) # 最低気温
      expect(result["main"]["feels_like"]).to eq(1.88) # 体感温度
      expect(result["wind"]["speed"]).to eq(8.75) # 風速
      expect(Time.at(result["sys"]["sunrise"]).to_i).to eq(1735249779) # 日の出の時間
      expect(Time.at(result["sys"]["sunset"]).to_i).to eq(1735284878) # 日の入りの時間
      expect(result["weather"][0]["main"]).to eq("Clouds") # 天気の概要
      expect(result["weather"][0]["description"]).to eq("few clouds") # 天気の詳細
      expect(result["weather"][0]["icon"]).to eq("02n") # アイコン
    end
  end

  describe ".attributes_for" do
    let(:weather_data) do
      {
        "coord" => { "lon" => 139.6917, "lat" => 35.6895 },
        "weather" => [
          {
            "id" => 801,
            "main" => "Clouds",
            "description" => "few clouds",
            "icon" => "02n"
          }
        ],
        "base" => "stations",
        "main" => {
          "temp" => 6.48,
          "feels_like" => 1.88,
          "temp_min" => 4.78,
          "temp_max" => 7.53,
          "pressure" => 1012,
          "humidity" => 43
        },
        "visibility" => 10000,
        "wind" => {
          "speed" => 8.75,
          "deg" => 340
        },
        "sys" => {
          "sunrise" => 1735249779,
          "sunset" => 1735284878
        }
      }
    end

    it "APIデータを正しい形式に変換" do
      result = WeatherApi.attributes_for(weather_data)

      expect(result[:weather_id]).to eq(801) # 天気ID
      expect(result[:humidity]).to eq(43) # 湿度
      expect(result[:deg]).to eq(340) # 風向き
      expect(result[:pressure]).to eq(1012) # 気圧
      expect(result[:visibility]).to eq(10000) # 視程
      expect(result[:temp_max]).to eq(7.53) # 最高気温
      expect(result[:temp_min]).to eq(4.78) # 最低気温
      expect(result[:temp_feel]).to eq(1.88) # 体感温度
      expect(result[:speed]).to eq(8.75) # 風速
      expect(result[:sunrise_date]).to eq(Time.at(1735249779).in_time_zone('UTC').in_time_zone) # 日の出の時間
      expect(result[:sunset_date]).to eq(Time.at(1735284878).in_time_zone('UTC').in_time_zone) # 日の入りの時間
      expect(result[:main]).to eq("Clouds") # 天気の概要
      expect(result[:description]).to eq("few clouds") # 天気の詳細
      expect(result[:icon]).to eq("02n") # アイコン
    end
  end
end
