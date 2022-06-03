class Admin::DotcomsController < Admin::BaseController
  before_action :set_dotcom, only: [:show, :edit, :update,:destroy]
  after_action  :remove_avatar, only: :update

  def index
    @dotcoms = policy_scope(Dotcom)
  end

  def show
    authorize @dotcom
  end

  def new
    @dotcom = Dotcom.new
    authorize @dotcom
  end

  def edit
    authorize @dotcom
  end

  def create
    @dotcom = Dotcom.new(dotcom_params)
    authorize @dotcom
    if @dotcom.save
      redirect_to admin_dotcom_path(@dotcom), notice: t('messages.created', model: @dotcom.class.model_name.human)
    else      
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @dotcom
    if @dotcom.update(dotcom_params)
      redirect_to admin_dotcom_path(@dotcom), notice: t('messages.updated', model: @dotcom.class.model_name.human)
    else      
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @dotcom
    @dotcom.destroy
    flash[:success] = t('messages.deleted', model: @dotcom.class.model_name.human)
    redirect_to admin_dotcoms_path
  end

  private

    # Uses callbacks to share common setup or constraints between actions
    def set_dotcom
      @dotcom = Dotcom.find(params[:id])
    end

    # Removes avatar, if selected during Editing
    def remove_avatar
      @dotcom.avatar.purge if dotcom_params[:remove_avatar] == '1'
    end

    # Only allows a trusted parameter 'white list' through
    def dotcom_params
      params.require(:dotcom).permit(
        :name, :status, :content, :avatar, :remove_avatar
      )
    end
end
