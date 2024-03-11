class ChangeNameColumnGenreForVinyls < ActiveRecord::Migration[7.1]
  def change
    rename_column :vinyls, :genre, :genres
  end
end
