class TradesController < ApplicationController
  require 'open-uri'
  require 'csv'
  require 'zip'
  include DataPro
  before_action :selected_from_dddl
  
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

  def import
    @dotcoms = Dotcom.active
    @pairs   = @dotcom.present? ? @dotcom.pairs.active : Pair.active.order(:code) || []
    @years   = Rails.configuration.years
    @months  = Rails.configuration.months
    # @months  = Date::ABBR_MONTHNAMES.compact

    if @dotcom.present? and @pair.present? and @year.present? and @month.present?
      t_start = current_clock_time

      local_directory = 'tmp/data/' + "#{@dotcom.name.capitalize}/"
      log_file         = File.open(local_directory + "download.log", "w")

      case @dotcom.name
      when 'binance'
        pair_symbol    = @pair.symbol(dotcom_name: @dotcom.name)

        # ZIP source
        remote_zip_file = "#{pair_symbol}-trades-#{@year.first}-#{@month.first}.zip"
        local_zip_file  = local_directory + remote_zip_file
        end_point      = "https://data.binance.vision/data/spot/monthly/trades/#{pair_symbol}/"
        url_zip        = end_point + remote_zip_file

        # Checksum file
        remote_checksum_file = remote_zip_file + '.CHECKSUM'
        local_checksum_file  = local_zip_file  + '.CHECKSUM'
        url_checksum        = end_point + remote_checksum_file
      when 'cexio'

      else

      end

      # Download ZIP & Checksum files
      File.open(local_zip_file, "wb") {|file| file.write URI.open(url_zip).read}
      File.open(local_checksum_file, "wb") {|file| file.write URI.open(url_checksum).read}

      # Checksum verification
      system "cd #{local_directory}; shasum -a 256 -c ./#{remote_checksum_file}"
      if $?.exitstatus == 0  # or: $?.success?
        File.write(log_file, "#{local_zip_file} OK\n", mode: 'a')
      else 
        File.write(log_file, "#{local_zip_file}: FAILED\nshasum process\n", mode: 'a')
      end

      t_finish_download = current_clock_time
      @download_time   = elapsed_time time_at_start: t_start, time_at_finish: t_finish_download

      # Unzip
      csv_file = local_zip_file.gsub('zip', 'csv')
      Zip::File.open(local_zip_file) do |file|
        file.each do |f|
          fpath = File.join(local_directory, f.name)
          file.extract(f, fpath) unless File.exist?(fpath)
        end
      end

      t_finish_unzip = current_clock_time
      @unzip_time = elapsed_time time_at_start: t_finish_download, time_at_finish: t_finish_unzip

      log_file.close unless log_file.nil?

      # Populate DB table Trades
      @trades_created =  0
      CSV.foreach(csv_file) do |row|
        kind = row[5] == true ? 'buy' : 'sell'
        Trade.create!(
          dotcom: @dotcom, pair: @pair,
          kind:   kind,
          price:  row[1].to_f,
          amount: row[2].to_f,
          tid:    row[0].to_i,
          timestamp: row[4].to_i / 1000
        )
        @trades_created += 1
        # break if @trades_created == 30
      end
      t_finish_populate = current_clock_time
      @fill_time = elapsed_time time_at_start: t_finish_unzip, time_at_finish: t_finish_populate
    else

    end
  end
end