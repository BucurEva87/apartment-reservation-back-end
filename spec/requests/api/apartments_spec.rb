require 'swagger_helper'

describe 'Apartment reservation API', type: :request do
  let(:user) { create(:user) }
  let(:bearer) { Doorkeeper::AccessToken.create!(resource_owner_id: user.id, application_id: 1) }

  # rubocop:disable Metrics/BlockLength
  path '/api/apartments' do
    post 'Create new apartment' do
      tags 'apartments'
      security [Bearer: []]
      consumes 'application/json'
      parameter name: :apartment, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string },
          city: { type: :string },
          photo: { type: :string },
          price: { type: :number }
        },
        required: %w[name description city photo price]
      }
      response '200', 'Apartment created' do
        let(:apartment) do
          { name: 'Test name',
            description: 'Test description',
            city: 'Test city',
            photo: 'https://images.pexels.com/photos/2510067/pexels-photo-2510067.jpeg',
            price: 999 }
        end
        run_test!
      end
    end

    get 'Index of apartments' do
      tags 'apartments'
      security [Bearer: []]
      produces 'application/json'
      response '200', 'Apartment list received' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   name: { type: :string },
                   description: { type: :string },
                   city: { type: :string },
                   photo: { type: :string },
                   price: { type: :number }
                 },
                 required: %w[name description city photo price]
               }
        run_test!
      end
    end
  end
  # rubocop:enable Metrics/BlockLength

  let(:apartment) { create(:apartment) }

  path '/api/apartments/{apartment_id}' do
    delete 'Delete apartment' do
      tags 'apartments'
      security [Bearer: []]
      parameter name: :apartment_id, in: :path, type: :string
      response '200', 'Apartment deleted' do
        run_test!
      end
    end
  end
end
