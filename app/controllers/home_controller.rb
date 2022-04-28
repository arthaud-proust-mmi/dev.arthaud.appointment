class HomeController < ApplicationController
    prepend_before_action :authenticate_user!, only: %i[ show ]
    def index
    end

    def show
        @meets_incoming = current_user.meets.incoming
    end
end
