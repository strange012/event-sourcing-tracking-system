# frozen_string_literal: true

class CreateJobs < ActiveRecord::Migration[8.0]
  def change
    create_table :jobs do |t|
      t.text :title, null: false, index: { unique: true }
      t.text :description

      t.timestamps
    end
  end
end
