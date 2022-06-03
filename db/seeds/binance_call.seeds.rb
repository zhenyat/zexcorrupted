begin
  if (Call.present? and not Call.exists?)
    dotcom = Dotcom.find_by name: 'binance'
    apis = Api.where dotcom: dotcom
    apis.each do |api|
      if api.mode == 'public_api'
        am = Call.create(
          api: api, name: 'ping', title: 'General endpoints: Test connectivity',
          link: 'https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#test-connectivity',
        )
        am.content.body = "Test connectivity to the Rest API.<br>
        <strong>GET /api/v3/ping</strong><br>
        Response: {}"
        am.save

        am = Call.create(
          api: api, name: 'time', title: 'General endpoints: Check server time',
          link: 'https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#check-server-time'
        )
        am.content.body = "Test connectivity to the Rest API and get the current server time.<br>
                            <strong>GET /api/v3/time</strong><br>
                            Response: {\"serverTime\": 1499827319559}"
        am.save

        am = Call.create(
          api: api, name: 'exchangeInfo', title: 'General endpoints: Exchange information',
          link: 'https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#exchange-information'
        )
        am.content.body = "Current exchange trading rules and symbol information<br>
                            <strong>GET /api/v3/exchangeInfo</strong><hr/>
                            <h5>Examples</h5>
                            No params: curl -X GET \"https://api.binance.com/api/v3/exchangeInfo\"<br>
                            Symbol: curl -X GET \"https://api.binance.com/api/v3/exchangeInfo?symbol=BNBBTC\"<br>
                            Symbols: curl -X GET \"https://api.binance.com/api/v3/exchangeInfo?symbols=%5B%22BNBBTC%22,%22BTCUSDT%22%5D\"<br>
                            or
                            curl -g GET 'https://api.binance.com/api/v3/exchangeInfo?symbols=[\"BTCUSDT\",\"BNBBTC\"]'
                          "
        am.save

        am = Call.create(
          api: api, name: 'depth', title: 'Market Data endpoints: Order book',
          link: 'https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#order-book'
        )
        am.content.body = "<strong>GET \"https://api.binance.com/api/v3/depth?symbol=BTCUSDT\"</strong><br>
                            Response:
                            {<br>
                              \"lastUpdateId\": 1027024,<br>
                              \"bids\": [<br>
                                [ <br>
                                  \"4.00000000\",     // PRICE<br>
                                  \"431.00000000\"    // QTY<br>
                                ]<br>
                              ],<br>
                              \"asks\": [<br>
                                [<br>
                                  \"4.00000200\",<br>
                                  \"12.00000000\"<br>
                                ]<br>
                              ]<br>
                            }
                          "
        am.save

        am = Call.create(
          api: api, name: 'trades', title: 'Market Data endpoints: Recent trades list',
          link: 'https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#recent-trades-list'
        )
        am.content.body = "<strong>GET \"https://api.binance.com/api/v3/trades?symbol=BTCUSDT</strong>\""
        am.save

        am = Call.create(
          api: api, name: 'historicalTrades', title: 'Market Data endpoints: Old trade lookup (MARKET_DATA)',
          link: 'https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#old-trade-lookup-market_data'
        )
        am.content.body = "GET /api/v3/historicalTrades"
        am.save

        am = Call.create(
          api: api, name: 'aggTrades', title: 'Market Data endpoints: Compressed/Aggregate trades list',
          link: 'https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#compressedaggregate-trades-list'
        )
        am.content.body = "GET /api/v3/aggTrades"
        am.save

        am = Call.create(
          api: api, name: 'klines', title: 'Market Data endpoints: Kline/Candlestick data',
          link: 'https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#klinecandlestick-data'
        )
        am.content.body = "GET /api/v3/klines"
        am.save

        am = Call.create(
          api: api, name: 'avgPrice', title: 'Market Data endpoints: Current average price',
          link: 'https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#current-average-price'
        )
        am.content.body = "GET /api/v3/avgPrice"
        am.save

        am = Call.create(
          api: api, name: 'ticker', title: 'Market Data endpoints: Ticker data',
          link: 'https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#24hr-ticker-price-change-statistics'
        )
        am.content.body = "
          <h5>24hr ticker price change statistics</h5>
          <strong>GET \"/api/v3/ticker/24hr\"</strong><br>
          24 hour rolling window price change statistics. Careful when accessing this with no symbol.<br>
          <h5>Symbol price ticker</h5>
          Best price/qty on the order book for a symbol or symbols.<br>
          <strong>GET \"api/v3/ticker/price\"</strong><br>
          <h5>Symbol order book ticker</h5>
          Best price/qty on the order book for a symbol or symbols.<br>
          <strong>GET \"api/v3/ticker/bookTicker\"</strong><br>
        "
        am.save
  
      elsif api.mode == 'private_api'
        am = Call.create(
          api: api, name: 'order', title: 'Account endpoints: Orders',
          link: 'https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#new-order--trade'
        )
        am.content.body = "
          <h5>New order (TRADE)</h5>
          Send in a new OCO<br>
          <strong>POST /api/v3/order (HMAC SHA256)</strong>
          <h5>Test new order (TRADE)</h5>
          Test new order creation and signature/recvWindow long.<br>
          Creates and validates a new order but does not send it into the matching engine.<br>
          <strong>POST /api/v3/order/test (HMAC SHA256)</strong><br>
          <h5>Query order (USER_DATA)</h5>
          Check an order's status.<br>
          <strong>GET /api/v3/order (HMAC SHA256)</strong><br>
          <h5>Cancel order (TRADE)</h5>
          Cancel an active order.<br>
          <strong>DELETE /api/v3/order (HMAC SHA256)</strong><br>
          <h5>New OCO (TRADE)</h5>
          Send in a new OCO<br>
          <strong>POST /api/v3/order/oco (HMAC SHA256)</strong>
        "
        am.save

        am = Call.create(
          api: api, name: 'openOrders', title: 'Account endpoints: Open orders',
          link: 'https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#cancel-all-open-orders-on-a-symbol-trade'
        )
        am.content.body = "
          <h5>Cancel All Open Orders on a Symbol (TRADE)</h5>
          Cancels all active orders on a symbol. This includes OCO orders.<br>
          <strong>DELETE /api/v3/openOrders (HMAC SHA256)</strong>br>
          <h5>Current open orders (USER_DATA)</h5>
          Get all open orders on a symbol. <strong>Careful</strong> when accessing this with no symbol.<br>
          <strong>GET /api/v3/openOrders  (HMAC SHA256)</strong>
        "
        am.save

        am = Call.create(
          api: api, name: 'allOrders', title: 'Account endpoints: All orders (USER_DATA)',
          link: 'https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#all-orders-user_data'
        )
        am.content.body = "
          Get all account orders; active, canceled, or filled.<br>
          <strong>GET /api/v3/allOrders (HMAC SHA256)</strong>
        "
        am.save

        am = Call.create(
          api: api, name: 'orderList', title: 'Account endpoints: OCO requests',
          link: 'https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#cancel-oco-trade'
        )
        am.content.body = "
          <h5>Cancel OCO (TRADE)<h5>
          Cancel an entire Order List<br>
          <strong>DELETE /api/v3/orderList (HMAC SHA256)</strong>
          <h5>Query OCO (USER_DATA)</h5>
          Retrieves a specific OCO based on provided optional parameters<br>
          <strong>GET /api/v3/orderList (HMAC SHA256)</strong>
        "
        am.save

        am = Call.create(
          api: api, name: 'allOrderList', title: 'Account endpoints: Query all OCO (USER_DATA)',
          link: 'https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#query-all-oco-user_data'
        )
        am.content.body = "
          Retrieves all OCO based on provided optional parameters<br>
          <strong>GET /api/v3/allOrderList (HMAC SHA256)</strong>
        "
        am.save

        am = Call.create(
          api: api, name: 'account', title: 'Account endpoints: Account information (USER_DATA',
          link: 'https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#account-information-user_data'
        )
        am.content.body = "
          Get current account information
          <strong>GET /api/v3/account (HMAC SHA256)</strong>
        "
        am.save

        am = Call.create(
          api: api, name: 'myTrades', title: 'Account endpoints: Account trade list (USER_DATA)',
          link: 'https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#account-trade-list-user_data'
        )
        am.content.body = "
          Get trades for a specific account and symbol.<br>
          GET /api/v3/myTrades  (HMAC SHA256)
        "
        am.save

        am = Call.create(
          api: api, name: 'rateLimit', title: 'Account endpoints: Query Current Order Count Usage (TRADE)',
          link: 'https://github.com/binance/binance-spot-api-docs/blob/master/rest-api.md#query-current-order-count-usage-trade'
        )
        am.content.body = "
          Displays the user's current order count usage for all intervals.<br>
          <strong>GET /api/v3/rateLimit/order</strong>
        "
        am.save

        # am = Call.create(
        #   api: api, name: '', title: '',
        #   link: ''
        # )
        # am.content.body = ""
        # am.save

      else          # Demo mode: public_api metrhods to be used
        # do nothing
      end
    end
    puts "===== 'Binance Call' #{Call.count} record(s) created"
  else
    puts "===== 'Binance Call' seeding skipped"
  end
rescue StandardError, AnotherError => e
  puts "----- Achtung! Something went wrong..."
  puts "#{e.inspect}"
end
