class TradesController < ApplicationController
  include DataPro
  
  def index
    t_start = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    
    @trades_added = []
    # Add last trades
    Pair.active.each do |pair|
      count_before = Trade.where(pair_id: pair.id).count
      
      add_trades pair
      
      count_after = Trade.where(pair_id: pair.id).count
      @trades_added << count_after - count_before
    end

    # Show collected trades
    @trades = []
    @pairs  = []
    
    Pair.active.each do |pair|
      @pairs  << pair.name
      @trades << Trade.where('pair_id = ? AND timestamp >= ?', pair.id, (Time.now - 1.day).to_i).order(tid: :desc) 
    end

    t_finish      = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    @time_elapsed = (t_finish - t_start).round(2)
  end
end