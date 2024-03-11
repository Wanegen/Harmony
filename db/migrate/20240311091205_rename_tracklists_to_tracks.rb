class RenameTracklistsToTracks < ActiveRecord::Migration[7.1]
  def change
    rename_table :tracklists, :tracks
  end
end
