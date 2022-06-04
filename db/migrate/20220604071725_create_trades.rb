class CreateTrades < ActiveRecord::Migration[7.0]
  def change
    create_table :trades do |t|
      t.references :dotcom, null: false, foreign_key: true
      t.references :pair,   foreign_key: true
      t.integer    :kind,   limit: 1
      t.decimal    :price,  precision: 15, scale: 5
      t.decimal    :amount, precision: 15, scale: 8
      t.integer    :tid
      t.integer    :timestamp

      t.timestamps
    end
  end
end
