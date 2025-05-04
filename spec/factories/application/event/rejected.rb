# frozen_string_literal: true

FactoryBot.define do
  factory :application_event_rejected, parent: :application_event, class: 'Application::Event::Rejected'
end
