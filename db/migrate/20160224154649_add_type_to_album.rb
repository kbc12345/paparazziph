class AddTypeToAlbum < ActiveRecord::Migration
  def change
    add_column :albums, :category, :string, :default => "photoman"
  end
end
