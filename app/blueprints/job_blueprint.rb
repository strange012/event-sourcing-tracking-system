# frozen_string_literal: true

class JobBlueprint < BaseBlueprint
  identifier :id

  fields :created_at, :updated_at, :title, :description

  field :status, preload: :last_event
  field :hired_candidates_count, if: INCLUDED, preload: :hired_applications
  field :rejected_candidates_count, if: INCLUDED, preload: :rejected_applications
  field :ongoing_candidates_count, if: INCLUDED, preload: :ongoing_applications
end
