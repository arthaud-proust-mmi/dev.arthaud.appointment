class MeetsController < ApplicationController
    prepend_before_action :authenticate_user!
    prepend_before_action :set_meet, only: %i[ show edit update destroy cancel ]
    before_action :own_meet, only: %i[ show edit update destroy cancel ]

    # GET /meets or /meets.json
    def index
        @meets = current_user.meets.to_come.order(:planned_at)
    end

    def index_old
        @meets = current_user.meets.old.order(:planned_at)
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

    def cancel
        respond_to do |format|
            if @meet.update(state: Meet::STATES[:canceled])
                format.html { redirect_to meet_url(@meet), notice: "Le rendez-vous a été annulé avec succès" }
                format.json { render :show, status: :ok, location: @meet }
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.json { render json: @meet.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /meets/1 or /meets/1.json
    # def destroy
    #     @meet.destroy

    #     respond_to do |format|
    #         format.html { redirect_to meets_url, notice: "Le rendez-vous a été supprimé avec succès" }
    #         format.json { head :no_content }
    #     end
    # end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_meet
            @meet = Meet.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def meet_params
            params.require(:meet).permit(:user_id, :service_id, :planned_at)
        end

        def own_meet
            unless (current_user.id == @meet.user.id) or (current_user.id == @meet.service.user.id)
                flash[:alert] = "Vous n'êtes pas associé à ce rendez-vous"
                redirect_to my_meet_path
            end
        end
end
