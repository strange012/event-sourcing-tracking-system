# frozen_string_literal: true

class BaseBlueprint < Blueprinter::Base
  INCLUDED = ->(name, _job, options) { options[:includes].include?(name.to_s) }

  field :type, if: ->(_name, job, _options) { job.class.respond_to?(:table_name) } do |object|
    object.class.table_name.singularize
  end
end
