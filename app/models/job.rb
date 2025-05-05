# frozen_string_literal: true

class Job < ApplicationRecord
  include PgSearch::Model

  has_many :events, class_name: 'Job::Event', dependent: :destroy
  has_many :applications, dependent: :destroy
  has_many :hired_applications, -> { hired }, class_name: 'Application'
  has_many :rejected_applications, -> { rejected }, class_name: 'Application'
  has_many :ongoing_applications, -> { ongoing }, class_name: 'Application'
  has_one :last_event, -> { last_events }, class_name: 'Job::Event'

  scope :with_last_events, ->(table_name) { with(table_name => Job::Event.last_events).joins("left join #{table_name} on jobs.id = #{table_name}.job_id") }
  scope :activated, -> { with_last_events('last_activated_events').where(last_activated_events: { type: 'Job::Event::Activated' }) }

  pg_search_scope :search_by, against: %i[title description]

  def status
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
    hired_applications.size
  end

  def rejected_candidates_count
    rejected_applications.size
  end

  def ongoing_candidates_count
    ongoing_applications.size
  end
end
