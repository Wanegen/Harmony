class CreateTracks < ActiveRecord::Migration[7.1]
  def change
    create_table :tracks do |t|
      t.string :title
      t.string :duration
      t.string :position
      t.string :preview_url
      t.references :vinyl, null: false, foreign_key: true

      t.timestamps
    end
  end
end
