class ProController < ApplicationController
    prepend_before_action :authenticate_user!, only: %i[ edit update ]
    before_action :set_user, only: %i[ index edit update ]
    before_action :pro_user, only: %i[ edit update ]

    def index
        if current_user && current_user.is_pro
            @meets_incoming = current_user.pro_meets.incoming
        end
    end

    def show
        @user = User.find_by!(slug: params[:slug], is_pro: true)
    end

    def edit
    end

    def update
        respond_to do |format|
            if @user.update(user_params)
                format.html { redirect_to pro_path, notice: "Votre profil a été modifié avec succès" }
                format.json { render :show, status: :ok, location: @user }
            else
                format.html { render :edit, status: :unprocessable_entity }
                format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end
    end


    private
        # Use callbacks to share common setup or constraints between actions.
        def set_user
            @user = current_user
        end

        # Only allow a list of trusted parameters through.
        def user_params
            params.require(:user).permit(:name, :profession, :description, :site, :contact, :adress).merge(slug: params.require(:user)[:name].parameterize)
        end

        def pro_user
            unless current_user.is_pro
                flash[:alert] = "Vous n'avez pas indiqué être professionnel dans votre compte"
                redirect_to pro_path
            end
        end
end 
