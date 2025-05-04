# frozen_string_literal: true

FactoryBot.define do
  factory :job_event_deactivated, parent: :job_event, class: 'Job::Event::Deactivated'
end
