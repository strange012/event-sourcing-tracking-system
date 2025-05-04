# frozen_string_literal: true

class MetaBlueprint < BaseBlueprint
  field :page, if: ->(_name, object, _options) { object[:scope].is_a?(Enumerable) } do |object|
    {
      number: object[:scope].current_page,
      size: object[:scope].limit_value,
      total_pages: object[:scope].total_pages,
      total_count: object[:scope].total_count
    }
  end
end
