# frozen_string_literal: true

FactoryBot.define do
  factory :application do
    candidate_name { Faker::Name.name }
    job

    trait :hired do
      after(:create) do |application|
        create(:application_event_interview, application:)
        create(:application_event_hired, application:)
      end
    end

    trait :rejected do
      after(:create) do |application|
        create(:application_event_hired, application:)
        create(:application_event_rejected, application:)
      end
    end

    trait :interview do
      after(:create) do |application|
        create(:application_event_rejected, application:)
        create(:application_event_hired, application:)
        create(:application_event_interview, application:)
      end
    end

    trait :applied

    trait :with_notes do
      transient do
        notes_count { 1 }
      end

      after(:create) do |application, evaluator|
        create_list(:application_event_note, evaluator.notes_count, application:)
      end
    end
  end
end
