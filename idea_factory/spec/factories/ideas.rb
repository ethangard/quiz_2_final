FactoryBot.define do
  RANDOM_100_CHARS = "hello world hello world hello world hello world hello world hello world hello world hello hello worl hello world hello world"

  factory :idea do
    title {Faker::Job.field}
    description {Faker::Company.name}
    association :user, factory: :user
  end
end
