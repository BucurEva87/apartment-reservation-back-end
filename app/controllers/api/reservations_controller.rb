module Api
  class ReservationsController < Api::ApplicationController
    def index
      @reservations = Reservation.all
      render json: { reservations: @reservations }
    end
  end
end
