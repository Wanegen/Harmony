class AddTracklistToVinyls < ActiveRecord::Migration[7.1]
  def change
    add_column :vinyls, :tracklist, :text
  end
end
