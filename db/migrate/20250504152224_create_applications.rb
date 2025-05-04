# frozen_string_literal: true

class CreateApplications < ActiveRecord::Migration[8.0]
  def change
    create_table :applications do |t|
      t.string :candidate_name, null: false
      t.references :job, null: false, foreign_key: true

      t.timestamps
    end
  end
end
