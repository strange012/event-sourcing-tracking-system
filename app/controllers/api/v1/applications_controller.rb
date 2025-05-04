# frozen_string_literal: true

class Api::V1::ApplicationsController < Api::V1::BaseController
  def index
    case Applications::List.call(query_params)
    in Success(applications)
      render_success(ApplicationBlueprint, applications)
    in Failure(error)
      render_error(error)
    end
  end
end
