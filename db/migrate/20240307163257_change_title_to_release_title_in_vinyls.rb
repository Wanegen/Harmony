class ChangeTitleToReleaseTitleInVinyls < ActiveRecord::Migration[7.1]
  def change
    rename_column :vinyls, :title, :release_title
  end
end
