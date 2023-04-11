module Api
  class ApartmentsController < Api::ApplicationController
    def index
      apartments = Apartment.all
      render json: { apartments: }
    end

    def show
      apartment = Apartment.find(params[:id])
      render json: { apartment: }
    end

    def create
      if current_user.role != 'admin'
        render(json: { error: 'Only an admin can create an apartment' }, status: 401)
        return
      end

      apartment = Apartment.new(name: apartment_params[:name],
                                description: apartment_params[:description],
                                photo: apartment_params[:photo],
                                city: apartment_params[:city],
                                price: apartment_params[:price])

      if apartment.save
        render(json: { success: 'Apartment was created', apartment: { id: apartment.id } }, status: 200)
      else
        render(json: { error: apartment.errors.full_messages }, status: 422)
      end
    end

    def update
      if current_user.role != 'admin'
        render(json: { error: 'Only an admin can update an apartment' }, status: 401)
        return
      end

      apartment = Apartment.find(params[:id])

      if apartment.update(apartment_params)
        render(json: { success: 'Apartment was updated' }, status: :ok)
      else
        render(json: { error: apartment.errors.full_messages }, status: 422)
      end
    end

    def destroy
      if current_user.role != 'admin'
        render(json: { error: 'Only an admin can destroy an apartment' }, status: 401)
        return
      end

      apartment = Apartment.find(params[:id])
      if apartment.destroy!
        render(json: { success: 'Apartment was destroyed' }, status: :ok)
      else
        render(json: { error: apartment.errors.full_messages }, status: 422)
      end
    end

    def apartment_params
      params.permit(:name, :description, :photo, :city, :price)
    end
  end
end
