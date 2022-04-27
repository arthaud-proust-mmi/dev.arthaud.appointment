class HomeController < ApplicationController
    def index
    end

    def show
        @meets_incoming = current_user.meets.incoming
    end
end
