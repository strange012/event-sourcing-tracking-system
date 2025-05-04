# frozen_string_literal: true

FactoryBot.define do
  factory :job_event_activated, parent: :job_event, class: 'Job::Event::Activated'
end
