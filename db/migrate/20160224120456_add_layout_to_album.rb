class AddLayoutToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :layout, :string, :default => "horizontal"
  end
end
