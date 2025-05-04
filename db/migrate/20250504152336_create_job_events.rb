# frozen_string_literal: true

class CreateJobEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :job_events do |t|
      t.references :job, null: false, foreign_key: true
      t.string :type, null: false
      t.jsonb :data

      t.datetime :created_at, null: false
    end

    add_index :job_events, :type
  end
end
