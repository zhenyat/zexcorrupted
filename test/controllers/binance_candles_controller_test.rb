require "test_helper"

class BinanceCandlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @binance_candle = binance_candles(:one)
  end

  test "should get index" do
    get binance_candles_url
    assert_response :success
  end

  test "should get new" do
    get new_binance_candle_url
    assert_response :success
  end

  test "should create binance_candle" do
    assert_difference("BinanceCandle.count") do
      post binance_candles_url, params: { binance_candle: { quote_volume: @binance_candle.quote_volume, taker_base_volume: @binance_candle.taker_base_volume, taker_quote_volume: @binance_candle.taker_quote_volume, trades: @binance_candle.trades } }
    end

    assert_redirected_to binance_candle_url(BinanceCandle.last)
  end

  test "should show binance_candle" do
    get binance_candle_url(@binance_candle)
    assert_response :success
  end

  test "should get edit" do
    get edit_binance_candle_url(@binance_candle)
    assert_response :success
  end

  test "should update binance_candle" do
    patch binance_candle_url(@binance_candle), params: { binance_candle: { quote_volume: @binance_candle.quote_volume, taker_base_volume: @binance_candle.taker_base_volume, taker_quote_volume: @binance_candle.taker_quote_volume, trades: @binance_candle.trades } }
    assert_redirected_to binance_candle_url(@binance_candle)
  end

  test "should destroy binance_candle" do
    assert_difference("BinanceCandle.count", -1) do
      delete binance_candle_url(@binance_candle)
    end

    assert_redirected_to binance_candles_url
  end
end
