class City < ApplicationRecord
  has_many :weathers, dependent: :destroy
end
