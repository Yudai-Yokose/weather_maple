require 'rails_helper'

RSpec.describe City, type: :model do
  describe "バリデーションのテスト" do
    let(:city) do
      City.new(
        name: "札幌市",
        prefecture: "北海道",
        region: "北海道",
        data_code: 1,
        openweathermap_city_code: 2128295
      )
    end

    it "有効なデータは保存できる" do
      expect(city).to be_valid
    end

    it "名前がnilの場合は保存できない" do
      city.name = nil
      expect(city).not_to be_valid
    end

    it "都道府県がnilの場合は保存できない" do
      city.prefecture = nil
      expect(city).not_to be_valid
    end

    it "地域がnilの場合は保存できない" do
      city.region = nil
      expect(city).not_to be_valid
    end

    it "データコードがnilの場合は保存できない" do
      city.data_code = nil
      expect(city).not_to be_valid
    end

    it "OpenWeatherMapの都市コードがnilの場合は保存できない" do
      city.openweathermap_city_code = nil
      expect(city).not_to be_valid
    end

    it "データコードが重複している場合は保存できない" do
      City.create(
        name: "サンプル市",
        prefecture: "北海道",
        region: "北海道",
        data_code: 1,
        openweathermap_city_code: 999999
      )
      expect(city).not_to be_valid
    end

    it "OpenWeatherMapの都市コードが重複している場合は保存できない" do
      City.create(
        name: "サンプル市",
        prefecture: "北海道",
        region: "北海道",
        data_code: 2,
        openweathermap_city_code: 2128295
      )
      expect(city).not_to be_valid
    end
  end

  describe "アソシエーションテスト" do
    it "Weatherモデルと関連付けられている" do
      association = City.reflect_on_association(:weathers)
      expect(association.macro).to eq(:has_many)
    end
  end

  describe "JSONデータテスト" do
    it "すべてのJSONデータがバリデーションをパスする" do
      json_file_path = Rails.root.join('db', 'city_list', 'city_list.json')
      json_data = JSON.parse(File.read(json_file_path), symbolize_names: true)

      json_data.each do |data|
        city = City.new(
          name: data[:name],
          prefecture: data[:prefecture],
          region: data[:region],
          data_code: data[:data_code],
          openweathermap_city_code: data[:openweathermap_city_code]
        )
        expect(city).to be_valid
      end
    end
  end
end
