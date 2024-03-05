class CreateVinyls < ActiveRecord::Migration[7.1]
  def change
    create_table :vinyls do |t|
      t.string :title
      t.string :artist_name
      t.integer :year
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
