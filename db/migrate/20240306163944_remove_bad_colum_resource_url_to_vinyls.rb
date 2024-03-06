class RemoveBadColumResourceUrlToVinyls < ActiveRecord::Migration[7.1]
  def change
    remove_column :vinyls, :resourceurl, :string
  end
end
