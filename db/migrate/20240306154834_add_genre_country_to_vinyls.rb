class AddGenreCountryToVinyls < ActiveRecord::Migration[7.1]
  def change
    add_column :vinyls, :genre, :string
    add_column :vinyls, :country, :string
  end
end
