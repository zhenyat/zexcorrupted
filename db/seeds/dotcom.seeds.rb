begin
  if (Dotcom.present? and not Dotcom.exists?)
    Dotcom.create name: 'binance'
    Dotcom.create name: 'cexio'
    Dotcom.create name: 'coinbase', status: 1
    Dotcom.create name: 'coinex',   status: 1
    Dotcom.create name: 'kraken',   status: 1

    puts "===== 'Dotcom' #{Dotcom.count} record(s) created"
  else
    puts "===== 'Dotcom' seeding skipped"
  end
rescue StandardError, AnotherError => e
  puts "----- Achtung! Something went wrong..."
  puts "#{e.inspect}"
end