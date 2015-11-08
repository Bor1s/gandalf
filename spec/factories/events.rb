FactoryGirl.define do
  factory :event do
    beginning_at { Time.current.next_week }

    factory :upcoming_event do
      beginning_at { Time.current.tomorrow }
    end

    factory :finished_event do
      beginning_at { Time.current.yesterday }
    end
  end
end
