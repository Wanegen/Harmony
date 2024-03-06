class AddResourceurlToVinyls < ActiveRecord::Migration[7.1]
  def change
    add_column :vinyls, :resourceurl, :string
  end
end
