# frozen_string_literal: true

class Jobs::List
  include BasicService

  param :params do
    option :search_by, optional: true
  end

  def call
    jobs = yield list_jobs(params)

    Success(jobs)
  end

  private

  def list_jobs(params)
    jobs = Job.order(created_at: :desc)
    jobs = jobs.search_by(params.search_by) if params.search_by.present?

    Success(jobs)
  end
end
