begin
  if (Pair.present? and not Pair.exists?)
    ### Base Currency: Euro
    base_id = Coin.find_by(code: 'EUR').id
    puts "--- Base: EUR"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'USD').id, code: 'EUR/USD', level: 'Major',
      decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "archived"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'GBP').id, code: 'EUR/GBP', level: 'Minor',
      # decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "archived"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'CHF').id, code: 'EUR/CHF', level: 'Minor',
      # decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "archived"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'JPY').id, code: 'EUR/JPY', level: 'Minor',
      # decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "archived"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'CAD').id, code: 'EUR/CAD', level: 'Minor',
      # decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "archived"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'AUD').id, code: 'EUR/AUD', level: 'Minor',
      # decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "archived"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'NZD').id, code: 'EUR/NZD', level: 'Minor',
      # decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "archived"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'RUB').id, code: 'EUR/RUB', level: 'Exotic',
      # decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "archived"

    ### Base Currency: USD
    base_id = Coin.find_by(code: 'USD').id
    puts "--- Base: USD"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'JPY').id, code: 'USD/JPY', level: 'Major',
      # decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "archived"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'CAD').id, code: 'USD/CAD', level: 'Major',
      # decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "archived"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'CHF').id, code: 'USD/CHF', level: 'Major',
      # decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "archived"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'RUB').id, code: 'USD/RUB', level: 'Exotic',
      # decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "archived"

    ### Base Currency: GBP
    base_id = Coin.find_by(code: 'GBP').id
    puts "--- Base: GBP"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'USD').id, code: 'GBP/USD', level: 'Major',
      # decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "archived"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'JPY').id, code: 'GBP/JPY', level: 'Minor',
      # decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "archived"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'CHF').id, code: 'GBP/CHF', level: 'Minor',
      # decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "archived"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'AUD').id, code: 'GBP/AUD', level: 'Minor',
      # decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "archived"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'CAD').id, code: 'GBP/CAD', level: 'Minor',
      # decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "archived"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'RUB').id, code: 'GBP/RUB', level: 'Exotic',
      # decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "archived"

    ### Base Currency: AUD
    base_id = Coin.find_by(code: 'AUD').id
    puts "--- Base: AUD"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'USD').id, code: 'AUD/USD', level: 'Major',
      # decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "archived"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'JPY').id, code: 'AUD/JPY', level: 'Minor',
      # decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "archived"

    ### Base Currency: NZD
    base_id = Coin.find_by(code: 'NZD').id
    puts "--- Base: NZD"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'USD').id, code: 'NZD/USD', level: 'Major',
      # decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "archived"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'JPY').id, code: 'NZD/JPY', level: 'Minor',
      # decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "archived"

    base_id = Coin.find_by(code: 'BTC').id
    puts "--- Base: BTC"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'USD').id, code: 'BTC/USD',
      # level: 'Major',decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "active"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'USDT').id, code: 'BTC/USDT',
      # level: 'Major',decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "active"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'EUR').id, code: 'BTC/EUR',
      # level: 'Major',decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "active"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'RUB').id, code: 'BTC/RUB', level: 'Exotic',
      # level: 'Major', decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0
  
    ### Base Currency: ETH
    base_id = Coin.find_by(code: 'ETH').id
    puts "--- Base: ETH"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'USD').id, code: 'ETH/USD',
      # level: 'Major',decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "active"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'USDT').id, code: 'ETH/USDT',
      # level: 'Major',decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "active"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'EUR').id, code: 'ETH/EUR',
      # level: 'Major', decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "active"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'RUB').id, code: 'ETH/RUB',
      # level: 'Exotic', decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0
  
    ### Base Currency: LTC
    base_id = Coin.find_by(code: 'LTC').id
    puts "--- Base: LTC"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'USD').id, code: 'LTC/USD',
      # level: 'Major',decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "active"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'USDT').id, code: 'LTC/USDT',
      # level: 'Major',decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "active"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'EUR').id, code: 'LTC/EUR',
      # level: 'Major',decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "active"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'RUB').id, code: 'LTC/RUB',
      # level: 'Exotic', decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0
  
    ### Base Currency: BCH
    base_id = Coin.find_by(code: 'BCH').id
    puts "--- Base: BCH"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'USD').id, code: 'BCH/USD',
      # level: 'Major',decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "active"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'USDT').id, code: 'BCH/USDT',
      # level: 'Major',decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "active"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'EUR').id, code: 'BCH/EUR',
      # level: 'Major',decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "active"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'RUB').id, code: 'BCH/RUB',
      # level: 'Exotic', decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0
  
    ### Base Currency: ETC
    base_id = Coin.find_by(code: 'ETC').id
    puts "--- Base: ETC"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'USD').id, code: 'ETC/USD',
      # level: 'Major',decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "active"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'USDT').id, code: 'ETC/USDT',
      # level: 'Major',decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "active"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'EUR').id, code: 'ETC/EUR',
      # level: 'Major',decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "active"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'RUB').id, code: 'ETC/RUB',
      # level: 'Exotic', decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0
  
    ### Base Currency: BTG
    base_id = Coin.find_by(code: 'BTG').id
    puts "--- Base: BTG"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'USD').id, code: 'BTG/USD',
      # level: 'Major',decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "active"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'USDT').id, code: 'BTG/USDT',
      # level: 'Major',decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "active"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'EUR').id, code: 'BTG/EUR',
      # level: 'Major',decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "active"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'RUB').id, code: 'BTG/RUB',
      # level: 'Exotic', decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0
  
    ### Base Currency: USDC
    base_id = Coin.find_by(code: 'USDC').id
    puts "--- Base: USDC"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'USD').id, code: 'USDC/USD',
      # level: 'Major',decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "active"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'USDT').id, code: 'USDC/USDT',
      # level: 'Major',decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "active"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'EUR').id, code: 'USDC/EUR',
      # level: 'Major',decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0, status: "active"
    Pair.create base_id: base_id, quote_id: Coin.find_by(code: 'RUB').id, code: 'USDC/RUB',
      # level: 'Exotic', decimal_places: 5, min_price: 0.5e0, max_price: 2.0, min_amount: 0.1e0,
      fee: 0.2e0
              
    puts "===== 'Pair' #{Pair.count} record(s) created"
  else
    puts "===== 'Pair' seeding skipped"
  end
rescue StandardError, AnotherError => e
  puts "----- Achtung! Something went wrong..."
  puts "#{e.inspect}"
end