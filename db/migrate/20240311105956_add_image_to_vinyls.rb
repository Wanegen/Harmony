class AddImageToVinyls < ActiveRecord::Migration[7.1]
  def change
    add_column :vinyls, :image, :string
  end
end
