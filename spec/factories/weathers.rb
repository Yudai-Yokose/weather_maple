FactoryBot.define do
  factory :weather do
    association :city
    weather_id { 800 }
    humidity { 60 }
    deg { 200 }
    pressure { 1012 }
    visibility { 10000 }
    temp_max { 25.5 }
    temp_min { 18.3 }
    temp_feel { 23.0 }
    speed { 5.0 }
    fetched_at { Time.current }
    sunrise_date { Time.current.beginning_of_day + 5.hours }
    sunset_date { Time.current.beginning_of_day + 19.hours }
    main { "Clear" }
    description { "clear sky" }
    icon { "01d" }
  end
end
