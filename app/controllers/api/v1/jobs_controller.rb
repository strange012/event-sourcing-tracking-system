# frozen_string_literal: true

class Api::V1::JobsController < Api::V1::BaseController
  def index
    case Jobs::List.call(query_params)
    in Success(jobs)
      render_success(JobBlueprint, jobs)
    in Failure(error)
      render_error(error)
    end
  end
end
