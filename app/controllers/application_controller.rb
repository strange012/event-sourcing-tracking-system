# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Dry::Monads[:result]

  DEFAULT_PAGE_SIZE = 100

  def query_params
    params.to_unsafe_h[:q]
  end

  def includes_params
    params.to_unsafe_h[:includes] || []
  end

  def render_success(blueprint, scope)
    scope = paginated(scope) if scope.is_a?(Enumerable)
    render json: blueprint.render(scope, root: :data, meta: MetaBlueprint.render_as_hash(scope:),
                                         includes: includes_params)
  end

  def render_error(error)
    rendered_error = ErrorBlueprint.render_as_json([error], root: :errors)
    render json: rendered_error, status: rendered_error.dig('errors', 0, 'status')
  end

  def paginated(scope)
    return scope unless params[:page]

    scope.page(params.dig(:page, :number) || 1).per(params.dig(:page, :size) || DEFAULT_PAGE_SIZE)
  end
end
