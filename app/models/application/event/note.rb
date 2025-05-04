# frozen_string_literal: true

class Application::Event::Note < Application::Event
  attribute :data, Application::Event::Note::Data.to_type

  delegate :content, to: :data
end
