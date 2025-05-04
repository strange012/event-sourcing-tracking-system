# frozen_string_literal: true

FactoryBot.define do
  factory :application_event, class: 'Application::Event' do
    application
  end
end
