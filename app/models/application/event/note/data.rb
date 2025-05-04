# frozen_string_literal: true

class Application::Event::Note::Data
  include StoreModel::Model

  attribute :content, :string

  validates :content, presence: true
end
