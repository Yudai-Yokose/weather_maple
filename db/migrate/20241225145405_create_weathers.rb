class CreateWeathers < ActiveRecord::Migration[7.2]
  def change
    create_table :weathers do |t|
      t.references :city, null: false, foreign_key: true
      t.integer :weather_id
      t.integer :humidity
      t.integer :deg
      t.integer :pressure
      t.integer :visibility
      t.float :temp_max
      t.float :temp_min
      t.float :temp_feel
      t.float :speed
      t.datetime :fetched_at, null: false
      t.datetime :sunrise_date
      t.datetime :sunset_date
      t.string :main
      t.string :description
      t.string :icon

      t.timestamps
    end
  end
end
