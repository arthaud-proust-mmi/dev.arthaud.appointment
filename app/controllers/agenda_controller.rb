class AgendaController < ApplicationController
  before_action :set_meet, only: %i[ show edit update destroy ]

  # GET /pro/agenda or /pro/agenda.json
  # retourne les dates qui concernent les services de l'utilisateur connecté (qui est pro)
  def index
    # @meets = current_user.services.map { |service| service.meets }
    # @meets = @meets.flatten
    # @meets = @meets.sort_by! {|u| u.planned_at_timestamp}
    # @meets = current_user.pro_meets.order(:planned_at)
    # @meets = current_user.pro_meets.where(planned_at: (Date.today)..(Date.today+1.month) ).order(:planned_at)
    @meets = current_user.pro_meets.to_come.order(:planned_at)
  end

  def index_old
    @meets = current_user.pro_meets.old.order(:planned_at)
  end

  # GET /meets/1 or /meets/1.json
  def show
  end

  # GET /meets/new
  def new
    @meet = Meet.new
  end

  # GET /meets/1/edit
  def edit
  end

  # POST /meets or /meets.json
  def create
    @service = Service.find(meet_params()[:service_id])
    @meet = Meet.new(meet_params)

    respond_to do |format|
      if @meet.save
        format.html { redirect_to meet_url(@meet), notice: "Rendez-vous pris" }
        format.json { render :show, status: :created, location: @meet }
      else
        format.html { render 'services/book', status: :unprocessable_entity }
        format.json { render json: @meet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meets/1 or /meets/1.json
  def update
    respond_to do |format|
      if @meet.update(meet_params)
        format.html { redirect_to meet_url(@meet), notice: "Le rendez-vous a été modifié avec succès" }
        format.json { render :show, status: :ok, location: @meet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @meet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meets/1 or /meets/1.json
  def destroy
    @meet.destroy

    respond_to do |format|
      format.html { redirect_to meets_url, notice: "Le rendez-vous a été supprimé avec succès" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meet
      @meet = Meet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def meet_params
      params.require(:meet).permit(:user_id, :service_id, :planned_at)
    end
end
