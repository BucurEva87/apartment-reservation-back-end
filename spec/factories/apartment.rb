FactoryBot.define do
  factory :apartment do
    name { 'Test name' }
    description { 'Test description' }
    city { 'Test city' }
    price { '999' }
  end
end
