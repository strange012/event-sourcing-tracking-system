# frozen_string_literal: true

class Application < ApplicationRecord
  include PgSearch::Model

  belongs_to :job
  has_many :events, class_name: 'Application::Event', dependent: :destroy

  scope :hired, -> { joins(:events).merge(Application::Event.last_for_application.hired) }
  scope :rejected, -> { joins(:events).merge(Application::Event.last_for_application.rejected) }
  scope :ongoing, lambda {
    left_joins(:events).merge(Application::Event.last_for_application).merge(Application::Event.interview.or(Application::Event.where(type: nil)))
  }

  scope :with_activated_job, -> { joins(:job).merge(Job.activated) }

  pg_search_scope :search_by, against: %i[candidate_name]

  def status
    last_event = events.order(:created_at).last
    return 'applied' unless last_event
    return 'interview' if last_event.is_a?(Application::Event::Interview)
    return 'hired' if last_event.is_a?(Application::Event::Hired)
    return 'rejected' if last_event.is_a?(Application::Event::Rejected)

    'applied'
  end

  def job_title
    job.title
  end

  def applied?
    status == 'applied'
  end

  def interview?
    status == 'interview'
  end

  def hired?
    status == 'hired'
  end

  def rejected?
    status == 'rejected'
  end

  def notes_count
    events.note.count
  end

  def last_interview_at
    events.interview.last&.created_at
  end
end
