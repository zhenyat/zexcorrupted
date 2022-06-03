class Admin::PairsController < Admin::BaseController
  before_action :set_pair, only: [:show, :edit, :update,:destroy]

  def index
    @pairs = policy_scope(Pair).order(:status).order(:code)
  end

  def show
    authorize @pair
  end

  def new
    @pair = Pair.new
    authorize @pair
  end

  def edit
    authorize @pair
  end

  def create
    @pair = Pair.new(pair_params)
    authorize @pair
    if @pair.save
      redirect_to admin_pair_path(@pair), notice: t('messages.created', model: @pair.class.model_name.human)
    else      
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @pair
    if @pair.update(pair_params)
      redirect_to admin_pair_path(@pair), notice: t('messages.updated', model: @pair.class.model_name.human)
    else      
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @pair
    @pair.destroy
    flash[:success] = t('messages.deleted', model: @pair.class.model_name.human)
    redirect_to admin_pairs_path
  end

  private

    # Uses callbacks to share common setup or constraints between actions
    def set_pair
      @pair = Pair.find(params[:id])
    end

    # Only allows a trusted parameter 'white list' through
    def pair_params
      params.require(:pair).permit(
        :false_id, :false_id, :code, :level, :decimal_places, :min_price, :max_price, :min_amount, :hidden, :fee, :status
      )
    end
end
