FactoryBot.define do
  factory :city do
    name { "札幌市" }
    prefecture { "北海道" }
    region { "北海道" }
    data_code { 1 }
    openweathermap_city_code { 2128295 }

    trait :aomori do
      name { "青森市" }
      prefecture { "青森県" }
      region { "東北" }
      data_code { 2 }
      openweathermap_city_code { 2130658 }
    end

    trait :sendai do
      name { "仙台市" }
      prefecture { "宮城県" }
      region { "東北" }
      data_code { 4 }
      openweathermap_city_code { 2111149 }
    end

    trait :tokyo do
      name { "東京都" }
      prefecture { "東京都" }
      region { "関東" }
      data_code { 13 }
      openweathermap_city_code { 1850147 }
    end

    trait :osaka do
      name { "大阪市" }
      prefecture { "大阪府" }
      region { "近畿" }
      data_code { 27 }
      openweathermap_city_code { 1853909 }
    end
  end
end
