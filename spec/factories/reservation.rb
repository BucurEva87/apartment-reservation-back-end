FactoryBot.define do
  factory :reservation do
    user { create(:user) }
    apartment { create(:apartment) }
    start_date { Date.today }
    end_date { Date.today + 1 }
  end
end
