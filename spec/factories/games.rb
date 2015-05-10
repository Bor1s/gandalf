# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game do

    title { Faker::Lorem.word }
    events_attributes {[FactoryGirl.attributes_for(:event)]}

    factory :game_with_upcoming_events do
      events_attributes {[FactoryGirl.attributes_for(:upcoming_event)]}
    end

    factory :game_with_finished_events do
      events_attributes {[FactoryGirl.attributes_for(:finished_event)]}
    end
  end
end
