# frozen_string_literal: true

class CreateApplicationEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :application_events do |t|
      t.references :application, null: false, foreign_key: true
      t.string :type, null: false
      t.jsonb :data

      t.datetime :created_at, null: false
    end

    add_index :application_events, :type
  end
end
