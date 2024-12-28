class CitiesController < ApplicationController
  def index
    @all_cities = City.all.group_by(&:region) # リスト用で天気情報は取得しないのでallでOK

    picked_up_city = City.where(data_code: [ 1, 4, 13, 23, 27, 34, 38, 40, 47 ]) # 札幌、仙台、東京、名古屋、大阪、広島、松山、福岡、那覇
    @picked_up_city_data = picked_up_city.includes(:weathers).map do |city| # 天気情報もとるのでincludes
      weather = fetch_weather(city) # fetch_weatherメソッドを呼び出し
      { city: city, weather: weather } # city情報の配列をcityとweatherをキーとするハッシュに変換して @weather_dataに代入
    end
  end

  def show
    @city = City.find_by(data_code: params[:id].to_i) # data_codeのid = city_id
    @weather = fetch_weather(@city)
  end

  private

  def fetch_weather(city)
    latest_data = city.weathers.order(fetched_at: :desc).first # 最新の天気情報
    if latest_data.nil? || latest_data.fetched_at.to_date != Time.current.to_date # 最新情報がない、または最新情報の日付が今日ではない
      Rails.logger.info "APIから天気データを取得!"
      request = WeatherApi.new(city.openweathermap_city_code) # true条件 => APIリクエスト
      response = request.get_weather # Ruby用にハッシュにしたレスポンスをresponseへ代入
      if response
        weather_data = WeatherApi.attributes_for(response) # Ruby用にハッシュにしたレスポンスをフロント表示用に変換
        latest_data = city.weathers.create(weather_data.merge(fetched_at: Time.current)) # 例外は発生させないのでcreate使う.元のハッシュを変更せず、新しいハッシュを生成するmergeメソッド使う
        Rails.logger.info "新しいデータをDBに保存しました!"
      end
    else
      Rails.logger.info "データベースから情報を取得しました!"
    end
    latest_data # 最後に取得、成形した対象の都市の天気情報を返す
  end
end
