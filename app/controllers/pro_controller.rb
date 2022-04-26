class ProController < ApplicationController
    before_action :set_user, only: %i[ show edit update destroy ]

    def index
        @user = current_user
        # if current_user
        #     redirect_to({ action: "show", id: current_user.id})
        # else
        #     render "index"
        # end
    end

    def show
        set_user
    end

    def edit
        @user = current_user
    end

    def update
        @user = current_user

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
            @user = User.find_by!(id: params[:id], is_pro: true)
        end

        # Only allow a list of trusted parameters through.
        def user_params
            params.require(:user).permit(:name, :profession, :description, :site, :contact)
        end
end 
