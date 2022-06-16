require "application_system_test_case"

class BinanceCandlesTest < ApplicationSystemTestCase
  setup do
    @binance_candle = binance_candles(:one)
  end

  test "visiting the index" do
    visit binance_candles_url
    assert_selector "h1", text: "Binance candles"
  end

  test "should create binance candle" do
    visit binance_candles_url
    click_on "New binance candle"

    fill_in "Quote volume", with: @binance_candle.quote_volume
    fill_in "Taker base volume", with: @binance_candle.taker_base_volume
    fill_in "Taker quote volume", with: @binance_candle.taker_quote_volume
    fill_in "Trades", with: @binance_candle.trades
    click_on "Create Binance candle"

    assert_text "Binance candle was successfully created"
    click_on "Back"
  end

  test "should update Binance candle" do
    visit binance_candle_url(@binance_candle)
    click_on "Edit this binance candle", match: :first

    fill_in "Quote volume", with: @binance_candle.quote_volume
    fill_in "Taker base volume", with: @binance_candle.taker_base_volume
    fill_in "Taker quote volume", with: @binance_candle.taker_quote_volume
    fill_in "Trades", with: @binance_candle.trades
    click_on "Update Binance candle"

    assert_text "Binance candle was successfully updated"
    click_on "Back"
  end

  test "should destroy Binance candle" do
    visit binance_candle_url(@binance_candle)
    click_on "Destroy this binance candle", match: :first

    assert_text "Binance candle was successfully destroyed"
  end
end
