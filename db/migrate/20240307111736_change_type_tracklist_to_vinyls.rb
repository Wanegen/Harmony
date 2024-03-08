class ChangeTypeTracklistToVinyls < ActiveRecord::Migration[7.1]
  def change
    change_column :vinyls, :tracklist, :string
  end
end
