#######################################################
#   Join table 'dotcoms_pairs' seeding
#######################################################
begin
  binance = Dotcom.find_by name: 'binance'
  %w(BCH/USDT BCH/EUR).each do |code|
    pair = Pair.find_by(code: code)
    binance.pairs << pair if (pair.present? and pair.active?)
  end
  %w(BTC/USDT BTC/EUR BTC/RUB).each do |code|
    pair = Pair.find_by(code: code)
    binance.pairs << pair if (pair.present? and pair.active?)
  end
  %w(ETC/USDT ETC/EUR).each do |code|
    pair = Pair.find_by(code: code)
    binance.pairs << pair if (pair.present? and pair.active?)
  end
  %w(ETH/USDT ETH/EUR ETH/RUB).each do |code|
    pair = Pair.find_by(code: code)
    binance.pairs << pair if (pair.present? and pair.active?)
  end
  %w(LTC/USDT LTC/EUR LTC/RUB).each do |code|
    pair = Pair.find_by(code: code)
    binance.pairs << pair if (pair.present? and pair.active?)
  end
  %w(USDC/USDT).each do |code|
    pair = Pair.find_by(code: code)
    binance.pairs << pair if (pair.present? and pair.active?)
  end
  puts "Binance #{binance.pairs.count} pairs added"

  cexio = Dotcom.find_by name: 'cexio'
  %w(BCH/USD BCH/USDT BCH/EUR BTC/USD BTC/USDT BTC/EUR).each do |code|
    pair = Pair.find_by(code: code)
    cexio.pairs << pair if (pair.present? and pair.active?)
  end
  %w(ETH/USD ETH/USDT ETH/EUR LTC/USD LTC/USDT LTC/EUR).each do |code|
    pair = Pair.find_by(code: code)
    cexio.pairs << pair if (pair.present? and pair.active?)
  end
  %w(USDC/USD USDC/USDT USDC/EUR).each do |code|
    pair = Pair.find_by(code: code)
    cexio.pairs << pair if (pair.present? and pair.active?)
  end
  puts "CEX.IO #{cexio.pairs.count} pairs added"

rescue StandardError, AnotherError => e
  puts "----- Achtung! Something went wrong..."
  puts "#{e.inspect}"
end