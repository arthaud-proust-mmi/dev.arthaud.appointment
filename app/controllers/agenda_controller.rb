class AgendaController < ApplicationController
    prepend_before_action :authenticate_user!
    prepend_before_action :pro_user
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

    private
        def pro_user
            unless current_user.is_pro
                flash[:alert] = "Vous n'avez pas indiqué être professionnel dans votre compte"
                redirect_to pro_path
            end
        end
end
