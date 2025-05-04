# frozen_string_literal: true

FactoryBot.define do
  factory :job_event, class: 'Job::Event' do
    job
  end
end
