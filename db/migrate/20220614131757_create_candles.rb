class CreateCandles < ActiveRecord::Migration[7.0]
  def change
    create_table :candles do |t|
      t.references :candlestick, null: false, foreign_key: true
      t.references :candleable,  polymorphic: true, null: false
      t.integer    :start_stamp, null: false
      t.decimal    :open,        null: false, precision: 15, scale: 5
      t.decimal    :high,        null: false, precision: 15, scale: 5
      t.decimal    :low,         null: false, precision: 15, scale: 5
      t.decimal    :close,       null: false, precision: 15, scale: 5
      t.decimal    :volume,      null: false, precision: 15, scale: 8

      t.timestamps
    end
  end
end
