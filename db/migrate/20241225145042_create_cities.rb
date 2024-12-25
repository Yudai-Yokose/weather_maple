class CreateCities < ActiveRecord::Migration[7.2]
  def change
    create_table :cities do |t|
      t.integer :data_code, null: false
      t.integer :openweathermap_city_code, null: false
      t.string :name, null: false
      t.string :prefecture, null: false
      t.string :region, null: false

      t.timestamps
    end

    add_index :cities, :data_code, unique: true, name: "index_cities_on_data_code"
    add_index :cities, :openweathermap_city_code, unique: true, name: "index_cities_on_openweathermap_city_code"
  end
end
