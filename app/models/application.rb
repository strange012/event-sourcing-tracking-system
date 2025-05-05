# frozen_string_literal: true

class Application < ApplicationRecord
  include PgSearch::Model

  belongs_to :job
  has_many :events, class_name: 'Application::Event', dependent: :destroy
  has_many :notes, class_name: 'Application::Event::Note'
  has_one :last_interview, -> { order(created_at: :desc) }, class_name: 'Application::Event::Interview'
  has_one :last_status_event, -> { last_status_events }, class_name: 'Application::Event'

  scope :with_last_status_events, ->(table_name) { with(table_name => Application::Event.last_status_events).joins("left join #{table_name} on applications.id = #{table_name}.application_id") }
  scope :hired, -> { with_last_status_events('last_hired_events').where(last_hired_events: { type: 'Application::Event::Hired' }) }
  scope :rejected, -> { with_last_status_events('last_rejected_events').where(last_rejected_events: { type: 'Application::Event::Rejected' }) }
  scope :ongoing, -> { with_last_status_events('last_ongoing_events').where(last_ongoing_events: { type: [nil, 'Application::Event::Interview'] }) }

  scope :with_activated_job, -> { joins(:job).merge(Job.activated) }

  pg_search_scope :search_by, against: %i[candidate_name]

  def status
    return 'applied' unless last_status_event
    return 'interview' if last_status_event.is_a?(Application::Event::Interview)
    return 'hired' if last_status_event.is_a?(Application::Event::Hired)
    return 'rejected' if last_status_event.is_a?(Application::Event::Rejected)

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
    notes.size
  end

  def last_interview_at
    last_interview&.created_at
  end
end
