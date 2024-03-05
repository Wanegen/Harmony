class CreateScans < ActiveRecord::Migration[7.1]
  def change
    create_table :scans do |t|
      t.jsonb :ai_response, default: {}

      t.timestamps
    end
  end
end
