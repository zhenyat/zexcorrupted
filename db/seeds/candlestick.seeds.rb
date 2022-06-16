begin

  if false      # Working mode: Create all possible Candlesticks
    Dotcom.active.each do |dotcom|
      dotcom.pairs.active.each do |pair|
        Candlestick.slots.each do |slot|
          Candlestick.create dotcom_id: dotcom.id, pair: pair, slot: slot[0]
        end
      end
    end
  else          # Testing mode
    slots = []
    Candlestick.slots.each {|slot| slots << slot}

    Candlestick.create dotcom: Dotcom.active.first, pair: Pair.find_by(code: 'BCH/USDT'), slot:  slots[0][0]
    Candlestick.create dotcom: Dotcom.active.first, pair: Pair.find_by(code: 'BTC/USDT'), slot:  slots[0][1]

    Candlestick.create dotcom: Dotcom.active.last, pair: Pair.find_by(code: 'BCH/EUR'), slot:  slots[1][0]
    Candlestick.create dotcom: Dotcom.active.last, pair: Pair.find_by(code: 'BTC/EUR'), slot:  slots[1][1]
  end

rescue StandardError, AnotherError => e
  puts "----- Achtung! Something went wrong..."
  puts "#{e.inspect}"
end
