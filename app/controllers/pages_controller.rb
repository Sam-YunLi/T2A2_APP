class PagesController < ApplicationController
    before_action :authenticate_user!, only: [:restricted]

    def home

    end
    
    def restricted

    end

    def owned_game
      
    end

end
