require 'rails_helper'

RSpec.describe CitiesController, type: :controller do
  describe "#fetch_weather" do
    let!(:city) { create(:city, openweathermap_city_code: 1850147) }
    let(:weather_data) do
      {
        weather_id: 801,
        humidity: 43,
        deg: 340,
        pressure: 1012,
        visibility: 10000,
        temp_max: 7.53,
        temp_min: 4.78,
        temp_feel: 1.88,
        speed: 8.75,
        sunrise_date: Time.current.beginning_of_day + 6.hours,
        sunset_date: Time.current.beginning_of_day + 18.hours,
        main: "Clouds",
        description: "few clouds",
        icon: "02n"
      }
    end

    before do
      allow_any_instance_of(WeatherApi).to receive(:get_weather).and_return(weather_data) # APIレスポンスをモック
      allow(WeatherApi).to receive(:attributes_for).and_return(weather_data) # attributes_forメソッドをモック
    end

    context "最新の天気データが存在しない場合" do
      it "APIから天気データを取得し、DBに保存する" do
        expect(city.weathers.count).to eq(0)
        get :show, params: { id: city.data_code }

        expect(city.weathers.count).to eq(1)
        weather = city.weathers.last

        expect(weather.weather_id).to eq(weather_data[:weather_id])
        expect(weather.humidity).to eq(weather_data[:humidity])
        expect(weather.deg).to eq(weather_data[:deg])
        expect(weather.pressure).to eq(weather_data[:pressure])
        expect(weather.visibility).to eq(weather_data[:visibility])
        expect(weather.temp_max).to eq(weather_data[:temp_max])
        expect(weather.temp_min).to eq(weather_data[:temp_min])
        expect(weather.temp_feel).to eq(weather_data[:temp_feel])
        expect(weather.speed).to eq(weather_data[:speed])
        expect(weather.sunrise_date.to_i).to eq(weather_data[:sunrise_date].to_i)
        expect(weather.sunset_date.to_i).to eq(weather_data[:sunset_date].to_i)
        expect(weather.main).to eq(weather_data[:main])
        expect(weather.description).to eq(weather_data[:description])
        expect(weather.icon).to eq(weather_data[:icon])
      end
    end

    context "最新の天気データが今日のものである場合" do
      it "APIを呼び出さず、DBのデータを使用する" do
        create(:weather, city: city, fetched_at: Time.current)
        expect(WeatherApi).not_to receive(:new)
        get :show, params: { id: city.data_code }
        expect(city.weathers.count).to eq(1)
      end
    end
  end
end
