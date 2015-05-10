FactoryGirl.define do
  factory :event do
    beginning_at { Time.now.next_week }

    factory :upcoming_event do
      beginning_at { Time.now.tomorrow }
    end

    factory :finished_event do
      beginning_at { Time.now.yesterday }
    end
  end
end
