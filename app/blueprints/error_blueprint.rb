# frozen_string_literal: true

class ErrorBlueprint < BaseBlueprint
  STATUSES = {
    invalid_argument: 422
  }.freeze

  DETAILS = {
    invalid_argument: 'Invalid or missing input attribute'
  }.freeze

  field :code do |error|
    error
  end

  field :status do |error|
    STATUSES[error.to_sym]
  end

  field :detail do |error|
    DETAILS[error.to_sym]
  end
end
