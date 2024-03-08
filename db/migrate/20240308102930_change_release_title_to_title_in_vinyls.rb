class ChangeReleaseTitleToTitleInVinyls < ActiveRecord::Migration[7.1]
  def change
    rename_column :vinyls, :release_title, :title
  end
end
