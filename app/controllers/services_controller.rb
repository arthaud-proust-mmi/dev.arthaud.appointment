class ServicesController < ApplicationController
    prepend_before_action :set_service, only: %i[ show edit update destroy ]
    prepend_before_action :authenticate_user!, only: %i[ book new create edit update destroy ]
    before_action :pro_user, only: %i[ new edit create update destroy]
    before_action :own_service, only: %i[ edit update destroy ]

    # GET /services or /services.json
    def index
        @services = Service.all
    end

    def book
        @meet = Meet.new
        set_service
    end

    def taken_dates
        set_service
    end

    # GET /pro/services/1 or /pro/services/1.json
    def show
    end

    # GET /pro/services/new
    def new
        @service = Service.new
    end

    # GET /pro/services/1/edit
    def edit
    end

    # POST /pro/services or /pro/services.json
    def create
        @service = Service.new(service_params)

        respond_to do |format|
            if @service.save
                format.html { redirect_to pro_path, notice: "Le service #{@service.title} a été créé avec succès" }
                format.json { render :show, status: :created, location: @service }
            else
                format.html { render :new, status: :unprocessable_entity }
                format.json { render json: @service.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /pro/services/1 or /pro/services/1.json
    def update
        respond_to do |format|
            if @service.update(service_params)
                format.html { redirect_to pro_path, notice: "Le service #{@service.title} a été modifié avec succès" }
                format.json { render :show, status: :ok, location: @service }
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.json { render json: @service.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /pro/services/1 or /pro/services/1.json
    def destroy
        @service.destroy

        respond_to do |format|
            format.html { redirect_to pro_path, notice: "Le service #{@service.title} a été supprimé avec succès" }
            format.json { head :no_content }
        end
    end

    private
        # Use callbacks to share common setup or constraints between actions.
        def set_service
            @service = Service.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def service_params
            params.require(:service).permit(:user_id, :title, :description, :price, :unit)
        end

        def own_service
            unless current_user.id == @service.user.id
                flash[:alert] = "Vous n'êtes pas associé à ce service"
                redirect_to pro_path
            end
        end

        def pro_user
            unless current_user.is_pro
                flash[:alert] = "Vous n'avez pas indiqué être professionnel dans votre compte"
                redirect_to pro_path
            end
        end
end
