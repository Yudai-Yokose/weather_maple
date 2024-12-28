require 'rails_helper'

RSpec.describe Weather, type: :model do
  describe "バリデーションのテスト" do
    let(:city) { City.create(name: "札幌市", prefecture: "北海道", region: "北海道", data_code: 1, openweathermap_city_code: 2128295) }
    let(:weather) do
      Weather.new(
        city: city,
        weather_id: 0,
        humidity: 0,
        deg: 0,
        pressure: 0,
        visibility: 0,
        temp_max: 0.0,
        temp_min: 0.0,
        temp_feel: 0.0,
        speed: 0,
        fetched_at: Time.at(0),
        sunrise_date: Time.at(0),
        sunset_date: Time.at(0),
        main: "不明",
        description: "不明",
        icon: "不明", # レスポンスがおかしかった場合のデフォルト値でテスト
      )
    end

    it "有効なデータは保存できる" do
      expect(weather).to be_valid
    end

    it "cityがnilの場合は保存できない" do
      weather.city = nil
      expect(weather).not_to be_valid
    end

    it "weather_idがnilの場合は保存できない" do
      weather.weather_id = nil
      expect(weather).not_to be_valid
    end

    it "humidityがnilの場合は保存できない" do
      weather.humidity = nil
      expect(weather).not_to be_valid
    end

    it "degがnilの場合は保存できない" do
      weather.deg = nil
      expect(weather).not_to be_valid
    end

    it "pressureがnilの場合は保存できない" do
      weather.pressure = nil
      expect(weather).not_to be_valid
    end

    it "visibilityがnilの場合は保存できない" do
      weather.visibility = nil
      expect(weather).not_to be_valid
    end

    it "temp_maxがnilの場合は保存できない" do
      weather.temp_max = nil
      expect(weather).not_to be_valid
    end

    it "temp_minがnilの場合は保存できない" do
      weather.temp_min = nil
      expect(weather).not_to be_valid
    end

    it "temp_feelがnilの場合は保存できない" do
      weather.temp_feel = nil
      expect(weather).not_to be_valid
    end

    it "speedがnilの場合は保存できない" do
      weather.speed = nil
      expect(weather).not_to be_valid
    end

    it "fetched_atがnilの場合は保存できない" do
      weather.fetched_at = nil
      expect(weather).not_to be_valid
    end

    it "sunrise_dateがnilの場合は保存できない" do
      weather.sunrise_date = nil
      expect(weather).not_to be_valid
    end

    it "sunset_dateがnilの場合は保存できない" do
      weather.sunset_date = nil
      expect(weather).not_to be_valid
    end

    it "mainがnilの場合は保存できない" do
      weather.main = nil
      expect(weather).not_to be_valid
    end

    it "descriptionがnilの場合は保存できない" do
      weather.description = nil
      expect(weather).not_to be_valid
    end

    it "iconがnilの場合は保存できない" do
      weather.icon = nil
      expect(weather).not_to be_valid
    end
  end

  describe "アソシエーションテスト" do
    it "Cityモデルと関連付けられている" do
      association = Weather.reflect_on_association(:city)
      expect(association.macro).to eq(:belongs_to)
    end
  end
end
