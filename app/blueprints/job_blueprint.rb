# frozen_string_literal: true

class JobBlueprint < BaseBlueprint
  identifier :id

  fields :created_at, :updated_at, :title, :description, :status

  field :hired_candidates_count, if: INCLUDED
  field :rejected_candidates_count, if: INCLUDED
  field :ongoing_candidates_count, if: INCLUDED
end
