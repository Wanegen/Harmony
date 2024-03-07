class AddResourceUrlToVinyls < ActiveRecord::Migration[7.1]
  def change
    add_column :vinyls, :resource_url, :string
  end
end
