class ChartsController < ApplicationController
  include ChartsPro

  def index
    @binance_data = apex_charts_data BinanceCandle.all
    @cexio_data   = apex_charts_data CexioCandle.all
  end
end
