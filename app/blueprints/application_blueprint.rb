# frozen_string_literal: true

class ApplicationBlueprint < BaseBlueprint
  identifier :id

  fields :created_at, :updated_at, :candidate_name

  field :status, preload: :last_status_event
  field :job_title, preload: :job
  field :notes_count, if: INCLUDED, preload: :notes
  field :last_interview_at, if: INCLUDED, preload: :last_interview
end
