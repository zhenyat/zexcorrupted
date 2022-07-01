module Zt
  ##############################################################################
  #   18.11.2016  ZT
  #   09.01.2017  Updated (following the RoR guide) *set_locale*
  #               *default_url_options* added
  #   15.11.2020  No classic autoloader: Zeitwerk only! 
  #   11.02.2022  locale_from_header
  #   24.06.2022  New methods 
  ##############################################################################

  def current_clock_time
    Process.clock_gettime(Process::CLOCK_MONOTONIC)
  end

  ##############################################################################
  # Adds multiple url options (*locale* here).
  #
  # An alternative solution: *polymorphic* urls (e.g. redirect_to polymorphic_url)
  ##############################################################################
  def default_url_options
    { locale: I18n.locale }
  end

  def elapsed_time time_at_start:, time_at_finish:
    (time_at_finish - time_at_start).round(2)
  end

  ##############################################################################
  #   Gets locale from page header
  #   https://www.youtube.com/watch?v=lCyP8uKRqQo&t=231s
  ##############################################################################
  def locale_from_header
    request.env.fetch('HTTP_ACCEPT_LANGUAGE', '').scan(/[a-z]{2}/).first
  end
 
  ##############################################################################
  #   Returns Month Index as from the abbreviated names array
  #   as a string '01' ... '12'
  #
  #   Not working (Error: uninitialized constant Zt::DATE)
  ##############################################################################
  def month_index abbr_name
    abbr_name = abbr_name.slice(0,3) if abbr_name.length > 3
    index = DATE::ABBR_MONTHNAMES.compact. find_index abbr_name
    index < 9 ? "0#{index+1}" : (index+1).to_s
  end

  # Selects instances from DDDLs - obsolete? (cause of an extra SELECT)
  def selected_from_dddl
    @dotcom  = Dotcom.find_by(id: params[:dotcom].presence)  # object.present? ? object : nil, 
    @api     = Api.find_by(id: params[:api].presence)
    @call    = Call.find_by(id: params[:call].presence)
    @pair    = Pair.find_by(id: params[:pair].presence)
    @slot    = Candlestick.slots[params[:slot].presence] # this is a value (0,1,2...)
                                                         # params[:slot] is a key: '1m', '3m',...
    @year    = Rails.configuration.years.select  {|e| e == params[:year].presence}
    @month   = Rails.configuration.months.select {|e| e == params[:month].presence}
  end

  ##############################################################################
  #   Sets locale  before_action
  #   Called by:   application_controller.rb & sessions_controller.rb
  ##############################################################################
  def set_locale
    I18n.locale = params[:locale] || locale_from_header || I18n.default_locale
  end

  def timestamp
    Time.now.strftime('%Y-%m-%d %H:%M:%S')
  end
end
