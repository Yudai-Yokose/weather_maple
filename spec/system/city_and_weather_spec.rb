require 'rails_helper'

RSpec.describe '天気情報ページ', type: :system, js: true do
  before do
    @city = create(:city)
    @weather = create(:weather, city: @city)
  end

  describe 'トップページ' do
    it '地域の天気情報が表示される' do
      visit root_path

      expect(page).to have_content("日本各地の天気情報をチェック")
      expect(page).to have_content(@city.name)
      expect(page).to have_content(@city.prefecture)
    end

    it '一覧ボタンをクリックすると全国の天気が表示される' do
      visit root_path

      find('label[for="my-drawer-4"]', match: :first).click
      within('.drawer-side') do
        expect(page).to have_content("#{@city.prefecture} / #{@city.name}")
      end
    end

    it "対象の都道府県のページに遷移する" do
      visit root_path
      find('label[for="my-drawer-4"]', match: :first).click
      within('.drawer-side') do
        click_link "#{@city.prefecture} / #{@city.name}"
      end
      expect(page).to have_current_path(city_path(id: @city.data_code), ignore_query: true)
      expect(page).to have_content(@city.prefecture)
      expect(page).to have_content(@city.name)
    end
  end

  describe '詳細ページ' do
    include ApplicationHelper

    it '指定した地域の詳細な天気情報が表示される' do
      visit city_path(@city.data_code)

      expect(page).to have_content(@city.name)
      expect(page).to have_content(@city.prefecture)
      expect(page).to have_content(@city.region)

      expect(page).to have_content(@weather.humidity.to_s)
      expect(page).to have_content(wind_direction(@weather.deg))
      expect(page).to have_content(@weather.pressure.to_s)
      expect(page).to have_content(visibility(@weather.visibility))
      expect(page).to have_content(@weather.temp_max.round.to_s)
      expect(page).to have_content(@weather.temp_min.round.to_s)
      expect(page).to have_content(@weather.temp_feel.round.to_s)
      expect(page).to have_content(@weather.speed.round.to_s)
      expect(page).to have_content(@weather.sunrise_date.strftime('%H:%M'))
      expect(page).to have_content(@weather.sunset_date.strftime('%H:%M'))
      expect(page).to have_content(main(@weather.main))
      expect(page).to have_content(description(@weather.description))
      weather_icon_path = "https://openweathermap.org/img/wn/#{@weather.icon}@2x.png"
      expect(page).to have_selector("img[src='#{weather_icon_path}']")
    end
  end
end
