module ApplicationHelper

  def default_meta_tags
    {
      site: 'Weather maple',
      title: '旅行前に現地の天気を確認するための天気情報サービス',
      reverse: true,
      charset: 'utf-8',
      description: 'Weather mapleを使えば、湿度や日の出日の入りの時間、風速なども確認できるため、服装選びや行動予定にも役立ちます',
      keywords: '天気、旅行',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: "/weathermaple.png",
        local: 'ja-JP'
      }
    }
  end

  def wind_direction(deg)
    case deg
    when 0..22, 338..360
      "北"
    when 23..67
      "北東"
    when 68..112
      "東"
    when 113..157
      "南東"
    when 158..202
      "南"
    when 203..247
      "南西"
    when 248..292
      "西"
    when 293..337
      "北西"
    end
  end

  def main(main)
    case main
    when "Clear"
      "晴れ"
    when "Clouds"
      "曇り"
    when "Rain"
      "雨"
    when "Drizzle"
      "霧雨"
    when "Thunderstorm"
      "雷雨"
    when "Snow"
      "雪"
    when "Mist"
      "霧"
    when "Smoke"
      "もや"
    when "Haze"
      "もや"
    when "Fog"
      "濃霧"
    when "Sand"
      "砂嵐"
    when "Dust"
      "ほこり"
    when "Ash"
      "火山灰"
    when "Squall"
      "スコール"
    when "Tornado"
      "竜巻"
    else
      main
    end
  end

  def description(description)
    case description
    when "clear sky"
      "快晴"
    when "few clouds"
      "薄い雲が出ています"
    when "scattered clouds"
      "少し雲が出ています"
    when "broken clouds"
      "雲が多めです"
    when "overcast clouds"
      "厚い雲がかかっています"
    when "light rain"
      "小雨"
    when "moderate rain"
      "雨"
    when "heavy intensity rain"
      "強い雨が降っています"
    when "very heavy rain"
      "非常に強い雨が降っています"
    when "extreme rain"
      "土砂降り"
    when "freezing rain"
      "雨と雪"
    when "light shower rain"
      "弱いにわか雨"
    when "shower rain"
      "にわか雨"
    when "heavy intensity shower rain"
      "強いにわか雨"
    when "thunderstorm with light rain"
      "小雨と雷"
    when "thunderstorm with heavy rain"
      "大雨と雷"
    when "light thunderstorm"
      "弱い雷雨"
    when "heavy thunderstorm"
      "激しい雷雨"
    when "light snow"
      "小雪"
    when "snow"
      "雪"
    when "heavy snow"
      "大雪"
    when "sleet"
      "みぞれ"
    when "shower sleet"
      "みぞれ"
    when "light rain and snow"
      "小雨と雪"
    when "rain and snow"
      "雨と雪"
    when "light shower snow"
      "にわか雪"
    when "shower snow"
      "にわか雪"
    when "heavy shower snow"
      "激しいにわか雪"
    when "mist"
      "霧"
    when "smoke"
      "もや"
    when "haze"
      "もや"
    when "fog"
      "濃霧"
    when "sand"
      "砂嵐"
    when "dust"
      "ほこり"
    when "volcanic ash"
      "火山灰"
    when "squalls"
      "スコール"
    when "tornado"
      "竜巻"
    else
      description
    end
  end

  def visibility(visibility)
    visibility_km = (visibility / 1000.0).round
    "#{visibility_km}"
  end
end
