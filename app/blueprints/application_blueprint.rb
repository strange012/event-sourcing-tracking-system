# frozen_string_literal: true

class ApplicationBlueprint < BaseBlueprint
  identifier :id

  fields :created_at, :updated_at, :candidate_name, :job_title, :status

  field :notes_count, if: INCLUDED
  field :last_interview_at, if: INCLUDED
end
