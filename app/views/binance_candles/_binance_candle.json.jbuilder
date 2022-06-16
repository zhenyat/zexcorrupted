json.extract! binance_candle, :id, :quote_volume, :trades, :taker_base_volume, :taker_quote_volume, :created_at, :updated_at
json.url binance_candle_url(binance_candle, format: :json)
