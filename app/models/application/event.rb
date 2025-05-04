# frozen_string_literal: true

class Application::Event < ApplicationRecord
  self.table_name = 'application_events'

  belongs_to :application

  scope :last_for_application, lambda {
    subquery = select('DISTINCT ON (application_id) application_events.*').where.not(type: 'Application::Event::Note').order('application_id, created_at DESC, id DESC')
    joins("left join (#{subquery.to_sql}) as t1 on application_events.id = t1.id")
  }

  scope :hired, -> { where(type: 'Application::Event::Hired') }
  scope :rejected, -> { where(type: 'Application::Event::Rejected') }
  scope :interview, -> { where(type: 'Application::Event::Interview') }
  scope :note, -> { where(type: 'Application::Event::Note') }
end
