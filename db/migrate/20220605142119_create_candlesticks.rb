class CreateCandlesticks < ActiveRecord::Migration[7.0]
  def change
    create_table :candlesticks do |t|
      t.references :dotcom, null: false, foreign_key: true
      t.references :pair,   null: false, foreign_key: true
      t.integer    :slot,   null: false, default: 0, limit: 1
      t.integer    :status, null: false, default: 0, limit: 1

      t.timestamps
    end
  end
end
