FactoryBot.define do
  factory :event do
    name { Faker::Name.name }
    organizer { Faker::Company.name }
    start_date { Faker::Date.between(from: '2022-06-23', to: '2022-09-25').to_datetime }
    end_date { Faker::Date.between(from: '2022-09-26', to: '2022-12-25').to_datetime }

    trait :co_berlin do
      type { 'CoBerlin' }
    end

    trait :visit_berlin do
      type { 'VisitBerlin' }
    end
  end
end
