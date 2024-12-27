require 'rails_helper'

RSpec.describe "Weather API", type: :request do
  include ApplicationHelper

  describe "GET /cities/:id" do
    let(:city) { create(:city) }
    let(:weather_data) do
      {
        weather_id: 800,
        humidity: 60,
        deg: 180,
        pressure: 1012,
        visibility: 10000,
        temp_max: 25.0,
        temp_min: 18.0,
        temp_feel: 22.0,
        speed: 5.0,
        sunrise_date: Time.now.beginning_of_day + 6.hours,
        sunset_date: Time.now.beginning_of_day + 18.hours,
        main: "Clear",
        description: "clear sky",
        icon: "01d"
      }
    end

    before do
      allow_any_instance_of(WeatherApi).to receive(:get_weather).and_return(weather_data)
      allow(WeatherApi).to receive(:attributes_for).and_return(weather_data)
    end

    it "正常系: 指定した地域の天気情報を取得できる" do
      get city_path(city.data_code)
      puts response.body
      expect(response).to have_http_status(:ok)
      html = Capybara::Node::Simple.new(response.body)

      expect(html).to have_content(city.name)
      expect(html).to have_content(city.prefecture)
      expect(html).to have_content(city.region)
      expect(html).to have_content(weather_data[:humidity])
      expect(html).to have_content(wind_direction(weather_data[:deg]))
      expect(html).to have_content("#{weather_data[:pressure]} hPa")
      expect(html).to have_content("#{visibility(weather_data[:visibility])} km")
      expect(html).to have_content(weather_data[:speed].to_i.to_s)
      expect(html).to have_content(weather_data[:sunrise_date].strftime('%H:%M'))
      expect(html).to have_content(weather_data[:sunset_date].strftime('%H:%M'))
      expect(html).to have_content(main(weather_data[:main]))
      expect(html).to have_content(description(weather_data[:description]))
      expect(html).to have_content(weather_data[:temp_max].to_i.to_s)
      expect(html).to have_content(weather_data[:temp_min].to_i.to_s)
      expect(html).to have_content(weather_data[:temp_feel].to_i.to_s)
      icon_url = "https://openweathermap.org/img/wn/#{weather_data[:icon]}@2x.png"
      expect(html).to have_selector("img[src='#{icon_url}']")
    end
  end
end
