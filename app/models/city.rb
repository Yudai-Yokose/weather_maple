class City < ApplicationRecord
  validates :name, presence: true
  validates :prefecture, presence: true
  validates :region, presence: true
  validates :data_code, presence: true, uniqueness: true
  validates :openweathermap_city_code, presence: true, uniqueness: true

  has_many :weathers, dependent: :destroy
end
