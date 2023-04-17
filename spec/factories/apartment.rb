FactoryBot.define do
  factory :apartment do
    name { 'Test name' }
    description { 'Test description' }
    city { 'Test city' }
    photo { 'https://images.pexels.com/photos/2510067/pexels-photo-2510067.jpeg' }
    price { '999' }
  end
end
