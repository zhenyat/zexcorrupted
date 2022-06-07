class CreateCandles < ActiveRecord::Migration[7.0]
  def change
    create_table :candles do |t|
      t.references :candlestick, null: false, foreign_key: true
      t.integer    :start_stamp,   null: false
      t.decimal    :open,          null: false, precision: 15, scale: 5
      t.decimal    :close,         null: false, precision: 15, scale: 5
      t.decimal    :low,           null: false, precision: 15, scale: 5
      t.decimal    :high,          null: false, precision: 15, scale: 5
      t.decimal    :amount_bought, null: false, precision: 15, scale: 8
      t.decimal    :amount_sold,   null: false, precision: 15, scale: 8
      t.integer    :buys,          null: false
      t.integer    :sales,         null: false

      t.timestamps
    end
  end
end
