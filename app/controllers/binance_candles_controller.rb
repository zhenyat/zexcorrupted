################################################################################
#  Updates the original file:
#     railties-5.0.0.beta1.1/lib/rails/generators/rails/scaffold_controller/templates/controller.rb
#
#  28.01.2016 ZT Localization added
################################################################################
class BinanceCandlesController < ApplicationController
  before_action :set_binance_candle, only: [:show, :edit, :update, :destroy]

  def index
    @binance_candles = BinanceCandle.all
  end

  def show
  end

  def new
    @binance_candle = BinanceCandle.new
  end

  def edit
  end

  def create
    @binance_candle = BinanceCandle.new(binance_candle_params)

    if @binance_candle.save
      redirect_to @binance_candle, notice: t('messages.created', model: BinanceCandle.class.model_name.human)
    else
      render :new
    end
  end

  def update
    if @binance_candle.update(binance_candle_params)
      redirect_to @binance_candle, notice: t('messages.updated', model: BinanceCandle.class.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @binance_candle.destroy
    redirect_to binance_candles_url, notice: t('messages.deleted', model: BinanceCandle.class.model_name.human)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_binance_candle
      @binance_candle = BinanceCandle.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def binance_candle_params
      params.require(:binance_candle).permit(:quote_volume, :trades, :taker_base_volume, :taker_quote_volume)
    end
end
