class CreateBinanceCandles < ActiveRecord::Migration[7.0]
  def change
    create_table :binance_candles do |t|
      t.decimal :quote_volume,       null: false, precision: 15, scale: 5
      t.integer :trades,             null: false
      t.decimal :taker_base_volume,  null: false, precision: 15, scale: 5
      t.decimal :taker_quote_volume, null: false, precision: 15, scale: 5

      t.timestamps
    end
  end
end
