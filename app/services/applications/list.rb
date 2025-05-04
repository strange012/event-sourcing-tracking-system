# frozen_string_literal: true

class Applications::List
  include BasicService

  param :params do
    option :search_by, optional: true
  end

  def call
    applications = yield list_applications(params)

    Success(applications)
  end

  private

  def list_applications(params)
    applications = Application.with_activated_job.order(created_at: :desc)
    applications = applications.search_by(params.search_by) if params.search_by.present?

    Success(applications)
  end
end
