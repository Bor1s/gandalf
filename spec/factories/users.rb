FactoryGirl.define do
  factory :user do
    email { Faker::Internet.free_email }
    nickname { Faker::Name.name }
    password '12345678'
    password_confirmation '12345678'
  end
end
