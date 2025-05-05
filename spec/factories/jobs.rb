# frozen_string_literal: true

FactoryBot.define do
  factory :job do
    title { Faker::Job.title }
    description { Faker::Lorem.sentence(word_count: 3, random_words_to_add: 7) }

    trait :activated do
      after(:create) do |job|
        create(:job_event_activated, job:)
      end
    end

    trait :with_hired_application do
      after(:create) do |job|
        create(:application, :hired, job:)
      end
    end

    trait :with_rejected_application do
      after(:create) do |job|
        create(:application, :rejected, job:)
      end
    end

    trait :with_interview_application do
      after(:create) do |job|
        create(:application, :interview, job:)
      end
    end

    trait :with_applied_application do
      after(:create) do |job|
        create(:application, :applied, job:)
      end
    end
  end
end
