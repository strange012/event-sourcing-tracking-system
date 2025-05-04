# frozen_string_literal: true

class Job::Event < ApplicationRecord
  self.table_name = 'job_events'

  belongs_to :job

  scope :last_for_job, lambda {
    subquery = select('DISTINCT ON (job_id) job_events.*').order('job_id, created_at DESC, id DESC')
    joins("left join (#{subquery.to_sql}) as t1 on job_events.id = t1.id")
  }

  scope :activated, -> { where(type: 'Job::Event::Activated') }
  scope :deactivated, -> { where(type: 'Job::Event::Deactivated') }
end
