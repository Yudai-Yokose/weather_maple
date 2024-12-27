FactoryBot.define do
  factory :city do
    sequence(:name) { |n| "都市#{n}" }
    prefecture { "北海道" }
    region { "北海道" }
    sequence(:data_code) { |n| n }
    sequence(:openweathermap_city_code) { |n| 2128000 + n }

    trait :hokkaido do
      name { "札幌市" }
      prefecture { "北海道" }
      region { "北海道" }
    end

    trait :kanto do
      name { "東京都" }
      prefecture { "東京都" }
      region { "関東" }
    end

    trait :kansai do
      name { "大阪市" }
      prefecture { "大阪府" }
      region { "関西" }
    end

    trait :kyushu do
      name { "福岡市" }
      prefecture { "福岡県" }
      region { "九州" }
    end

    trait :tohoku do
      name { "仙台市" }
      prefecture { "宮城県" }
      region { "東北" }
    end
  end
end
