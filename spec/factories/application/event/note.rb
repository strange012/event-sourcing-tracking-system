# frozen_string_literal: true

FactoryBot.define do
  factory :application_event_note, parent: :application_event, class: 'Application::Event::Note' do
    data { { content: Faker::Lorem.sentence(word_count: 3, random_words_to_add: 7) } }
  end
end
