require 'swagger_helper'

describe 'Apartment reservation API', type: :request do
  let(:user) { create(:user) }
  let(:token) { Doorkeeper::AccessToken.create!(resource_owner_id: user.id, application_id: 1) }

  it 'returns data with Doorkeeper token' do
    post '/api/apartments', headers: {
      'Authorization' => "Bearer #{token.token}",
      'Content-Type' => 'application/json'
    } do
      tags 'apartments'
      security [Bearer: []]
      consumes 'application/json'
      produces 'application/json'

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
  end

  it 'returns data with Doorkeeper token' do
    get '/api/apartments', headers: {
      'Authorization' => "Bearer #{token.token}",
      'Content-Type' => 'application/json'
    } do
      tags 'apartments'
      security [Bearer: []]
      produces 'application/json'

      response(200, 'Apartment list received') do
        schema type: :array,
               properties: {
                 name: { type: :string },
                 description: { type: :string },
                 city: { type: :string },
                 photo: { type: :string },
                 price: { type: :number }
               },
               required: %w[name description city photo price]
        run_test!
      end
    end
  end

  let(:id) { create(:apartment).id }

  it 'returns data with Doorkeeper token' do
    delete api_apartment_path(id), headers: {
      'Authorization' => "Bearer #{token.token}",
      'Content-Type' => 'application/json'
    } do
      tags 'apartments'
      security [Bearer: []]
      produces 'application/json'

      response(200, 'Apartment deleted') do
        run_test!
      end
    end
  end
end
