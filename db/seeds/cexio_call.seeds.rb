begin
  existing_methdos = Call.count
  dotcom = Dotcom.find_by name: 'cexio'
  apis = Api.where dotcom: dotcom
  apis.each do |api|
    if api.mode == 'public_api'
      am = Call.create(
        api: api, name: 'currency_limits', title: 'Currency limits',
        link: 'https://cex.io/rest-api#currency-limits'
      )
      am.content.body = "<strong>GET https://cex.io/api/currency_limits<br></strong>"
      am.save

      am = Call.create(
        api: api, name: 'time', title: 'Ticker',
        link: 'https://cex.io/rest-api#ticker'
      )
      am.content.body = "<strong>GET https://cex.io/api/ticker/{symbol1}/{symbol2}</strong>"
      am.save

      am = Call.create(
        api: api, name: 'exchangeInfo', title: 'Tickers for all pairs by markets',
        link: 'https://cex.io/rest-api#tickers-for-all-pairs-by-markets'
      )
      am.content.body = "
        <strong>GET https://cex.io/api/tickers/{marketSymbol1}/{marketSymbol2}/.../{marketSymbolN}</strong><hr/>
      "
      am.save

      am = Call.create(
        api: api, name: 'last-price', title: 'Last price',
        link: 'https://cex.io/rest-api#last-price'
      )
      am.content.body = "<strong>GET https://cex.io/api/last_price/{symbol1}/{symbol2}</strong>"
      am.save

      am = Call.create(
        api: api, name: 'last_prices', title: 'Last prices for given markets',
        link: 'https://cex.io/rest-api#last-prices-for-given-markets'
      )
      am.content.body = "
      <strong>GET https://cex.io/api/last_prices/{marketSymbol1}/{marketSymbol2}/.../{marketSymbolN}</strong>\""
      am.save

      am = Call.create(
        api: api, name: 'converter', title: 'Converter)',
        link: 'https://cex.io/rest-api#converter'
      )
      am.content.body = "<strong>POST https://cex.io/api/convert/{symbol1}/{symbol2}</strong>"
      am.save

      am = Call.create(
        api: api, name: 'price_stats', title: 'Chart',
        link: 'https://cex.io/rest-api#chart'
      )
      am.content.body = "<strong>POST https://cex.io/api/price_stats/{symbol1}/{symbol2}</strong>"
      am.save

      am = Call.create(
        api: api, name: 'ohlcv', title: 'Historical 1m OHLCV Chart',
        link: 'https://cex.io/rest-api#historical-1m-ohlcv-chart'
      )
      am.content.body = "GET /api/v3/klines"
      am.save

      am = Call.create(
        api: api, name: 'avgPrice', title: 'Market Data endpoints: Current average price',
        link: 'https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#current-average-price'
      )
      am.content.body = "<strong>GET https://cex.io/api/ohlcv/hd/{date}/{symbol1}/{symbol2}</strong>"
      am.save

      am = Call.create(
        api: api, name: 'order_book', title: 'Orderbook',
        link: 'https://cex.io/rest-api#orderbook'
      )
      am.content.body = "<strong>GET https://cex.io/api/order_book/{symbol1}/{symbol2}/</strong>"
      am.save

      am = Call.create(
        api: api, name: 'trade_history', title: 'Trade history',
        link: 'https://cex.io/rest-api#trade-history'
      )
      am.content.body = "<strong>GET https://cex.io/api/trade_history/{symbol1}/{symbol2}/</strong>"
      am.save
  
    elsif api.mode == 'private_api'
      am = Call.create(
        api: api, name: 'balance', title: 'Account balance',
        link: 'https://cex.io/rest-api#account-balance'
      )
      am.content.body = "<strong>POST https://cex.io/api/balance/</strong>"
      am.save

      am = Call.create(
        api: api, name: 'open_orders', title: 'Open orders',
        link: 'https://cex.io/rest-api#open-orders'
      )
      am.content.body = "
        Open orders: <strong>POST https://cex.io/api/open_orders/</strong><br>
        Open orders by pair: <strong>POST https://cex.io/api/open_orders/{symbol1}/{symbol2}</strong>
      "
      am.save

      am = Call.create(
        api: api, name: 'active_orders_status', title: 'Active order status',
        link: 'https://cex.io/rest-api#active-order-status'
      )
      am.content.body = "
        <strong>POST https://cex.io/api/active_orders_status</strong>
      "
      am.save

      am = Call.create(
        api: api, name: 'cancel_order', title: 'Cancel order',
        link: 'https://cex.io/rest-api#cancel-order'
      )
      am.content.body = "
        <strong>POST https://cex.io/api/cancel_order/</strong>
      "
      am.save

      am = Call.create(
        api: api, name: 'cancel_orders', title: 'Cancel all orders for given pair',
        link: 'https://cex.io/rest-api#cancel-all-orders-for-given-pair'
      )
      am.content.body = "
        <strong>POST https://cex.io/api/cancel_orders/{symbol1}/{symbol2}</strong>
      "
      am.save

      am = Call.create(
        api: api, name: 'place_order', title: 'Place order',
        link: 'https://cex.io/rest-api#place-order'
      )
      am.content.body = "
        <strong>POST https://cex.io/api/place_order/{symbol1}/{symbol2}</strong>
      "
      am.save

      am = Call.create(
        api: api, name: 'get_order', title: 'Get order details',
        link: 'https://cex.io/rest-api#get-order-details'
      )
      am.content.body = "
        <strong>POST https://cex.io/api/get_order/</strong>
      "
      am.save

      am = Call.create(
        api: api, name: 'get_order_tx', title: 'Get order transactions',
        link: 'https://cex.io/rest-api#get-order-transactions'
      )
      am.content.body = "
        <strong>POST https://cex.io/api/get_order_tx/</strong>
      "
      am.save

      am = Call.create(
        api: api, name: 'get_address', title: 'Get crypto address',
        link: 'https://cex.io/rest-api#get-crypto-address'
      )
      am.content.body = "<strong>POST https://cex.io/api/get_address/</strong>"
      am.save

      am = Call.create(
        api: api, name: 'get_crypto_address', title: 'Get all crypto addresses',
        link: 'https://cex.io/rest-api#get-all-crypto-addresses'
      )
      am.content.body = "<strong>POST https://cex.io/api/get_crypto_address</strong>"
      am.save

      am = Call.create(
        api: api, name: 'get_myfee', title: 'Get my fee',
        link: 'https://cex.io/rest-api#get-my-fee'
      )
      am.content.body = "<strong>POST https://cex.io/api/get_myfee/</strong>"
      am.save

      am = Call.create(
        api: api, name: 'cancel_replace_order', title: 'Cancel replace order',
        link: 'https://cex.io/rest-api#cancel-replace-order'
      )
      am.content.body = "
        <strong>POST https://cex.io/api/cancel_replace_order/{symbol1}/{symbol2}</strong>
      "
      am.save

    else          # Demo mode: public_api metrhods to be used
      # do nothing
    end
  end
  puts "===== 'CEX.IO Call' #{Call.count - existing_methdos} record(s) created"
rescue StandardError, AnotherError => e
  puts "----- Achtung! Something went wrong..."
  puts "#{e.inspect}"
end
