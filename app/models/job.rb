# frozen_string_literal: true

class Job < ApplicationRecord
  include PgSearch::Model

  has_many :events, class_name: 'Job::Event', dependent: :destroy
  has_many :applications, dependent: :destroy

  scope :activated, -> { joins(:events).merge(Job::Event.last_for_job.activated) }

  pg_search_scope :search_by, against: %i[title description]

  def status
    last_event = events.order(:created_at).last
    return 'deactivated' unless last_event
    return 'deactivated' if last_event.is_a?(Job::Event::Deactivated)

    'activated'
  end

  def activated?
    status == 'activated'
  end

  def deactivated?
    status == 'deactivated'
  end

  def hired_candidates_count
    applications.hired.count
  end

  def rejected_candidates_count
    applications.rejected.count
  end

  def ongoing_candidates_count
    applications.ongoing.count
  end
end
