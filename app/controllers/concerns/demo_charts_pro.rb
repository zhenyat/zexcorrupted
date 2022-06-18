module DemoChartsPro
  extend ActiveSupport::Concern

  # ApexCharts
  def candlestick_data
    @acc = rand(6570..6650)
    60.times.map {|i| [Date.today - 60 + i, ohlc] }.to_h
  end

  def ohlc
    open = @acc + rand(-20..20)
    high = open + rand(0..100)
    low = open - rand(0..100)
    @acc = close = open + rand(-((high-low)/3)..((high-low)/2))
    [open, high, low, close]
  end

  @candlestick_options = {
    plot_options: {
      candlestick: {
        colors: {
          upward: '#3C90EB',
          downward: '#DF7D46'
        }
      }
    }
  }
end