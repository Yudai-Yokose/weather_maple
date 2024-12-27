class Weather < ApplicationRecord
  belongs_to :city

  validates :weather_id, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :humidity, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :deg, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 360 }
  validates :pressure, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :visibility, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :fetched_at, presence: true
  validates :temp_max, :temp_min, :temp_feel, numericality: { greater_than_or_equal_to: -50, less_than_or_equal_to: 50 }
  validates :speed, numericality: { greater_than_or_equal_to: 0 }
  validates :sunrise_date, :sunset_date, presence: true
  validates :main, presence: true
  validates :description, presence: true
  validates :icon, presence: true
end
