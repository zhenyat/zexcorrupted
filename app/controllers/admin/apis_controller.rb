class Admin::ApisController < Admin::BaseController
  before_action :set_api, only: [:show, :edit, :update,:destroy]

  def index
    @apis = policy_scope(Api)
  end

  def show
    authorize @api
  end

  def new
    @api = Api.new
    authorize @api
  end

  def edit
    authorize @api
  end

  def create
    @api = Api.new(api_params)
    authorize @api
    if @api.save
      redirect_to admin_api_path(@api), notice: t('messages.created', model: @api.class.model_name.human)
    else      
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @api
    if @api.update(api_params)
      redirect_to admin_api_path(@api), notice: t('messages.updated', model: @api.class.model_name.human)
    else      
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @api
    @api.destroy
    flash[:success] = t('messages.deleted', model: @api.class.model_name.human)
    redirect_to admin_apis_path
  end

  private

    # Uses callbacks to share common setup or constraints between actions
    def set_api
      @api = Api.find(params[:id])
    end

    # Only allows a trusted parameter 'white list' through
    def api_params
      params.require(:api).permit(
        :dotcom_id, :mode, :base_url, :path, :key, :secret, :user, :status
      )
    end
end
