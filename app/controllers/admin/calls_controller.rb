class Admin::CallsController < Admin::BaseController
  before_action :set_call, only: [:show, :edit, :update,:destroy]

  def index
    @calls = policy_scope(Call)
  end

  def show
    authorize @call
  end

  def new
    @call = Call.new
    authorize @call
  end

  def edit
    authorize @call
  end

  def create
    @call = Call.new(call_params)
    authorize @call
    if @call.save
      redirect_to admin_call_path(@call), notice: t('messages.created', model: @call.class.model_name.human)
    else      
      render :new, status: :unprocessable_entity
    end
  end

  def update
    authorize @call
    if @call.update(call_params)
      redirect_to admin_call_path(@call), notice: t('messages.updated', model: @call.class.model_name.human)
    else      
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @call
    @call.destroy
    flash[:success] = t('messages.deleted', model: @call.class.model_name.human)
    redirect_to admin_calls_path
  end

  private

    # Uses callbacks to share common setup or constraints between actions
    def set_call
      @call = Call.find(params[:id])
    end

    # Only allows a trusted parameter 'white list' through
    def call_params
      params.require(:call).permit(
        :api_id, :name, :title, :link, :status, :content
      )
    end
end
