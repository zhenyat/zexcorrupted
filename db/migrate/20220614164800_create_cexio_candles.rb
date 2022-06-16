class CreateCexioCandles < ActiveRecord::Migration[7.0]
  def change
    create_table :cexio_candles do |t|

      t.timestamps
    end
  end
end
