module Api
  class ReservationsController < Api::ApplicationController
    def index
      @reservations = current_user.reservations.all
      render json: { reservations: @reservations }
    end
  end
end
