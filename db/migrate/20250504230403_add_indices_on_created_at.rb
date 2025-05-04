class AddIndicesOnCreatedAt < ActiveRecord::Migration[8.0]
  def change
    add_index :job_events, :created_at
    add_index :application_events, :created_at
  end
end
