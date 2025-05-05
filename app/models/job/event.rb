# frozen_string_literal: true

class Job::Event < ApplicationRecord
  self.table_name = 'job_events'

  belongs_to :job

  scope :last_events, -> { select('DISTINCT ON (job_id) job_events.*').order(job_id: :asc, created_at: :desc, id: :desc) }

  scope :activated, -> { where(type: 'Job::Event::Activated') }
  scope :deactivated, -> { where(type: 'Job::Event::Deactivated') }
end
