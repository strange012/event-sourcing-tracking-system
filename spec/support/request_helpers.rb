# frozen_string_literal: true

module RequestHelpers
  def json_body
    ActiveSupport::HashWithIndifferentAccess.new(JSON.parse(response.body))
  end
end
