# frozen_string_literal: true

module BasicService
  extend ActiveSupport::Concern

  included do
    extend Dry::Initializer
    include Dry::Monads[:maybe, :result, :do, :try, :list]
  end

  class_methods do
    def call(*)
      instance = new(*)
    rescue KeyError
      Dry::Monads::Failure(:invalid_argument)
    else
      instance.call
    end
  end
end
