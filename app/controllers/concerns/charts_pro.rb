module ChartsPro
  extend ActiveSupport::Concern

  # ApexCharts
  # [                            or    {
  #   [datetime, [O,H,L,C]],             datetime => [O,H,L,C],
  #   [datetime, [O,H,L,C]],             datetime => [O,H,L,C],
  #   ...                               ...
  # ]                                  }
  #######################################################################
  def apex_charts_data dotcom_candles
    ohlc = []
    dotcom_candles.each do |element|
      ohlc << [
        Time.at(element.candle.start_stamp).strftime("%Y-%m-%d %H:%M:%S"),
        [
          element.candle.open,
          element.candle.high,
          element.candle.low,
          element.candle.close
        ]
      ]
    end
    ohlc.to_h
  end
end
