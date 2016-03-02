class AddCreatedAtToPhotosAndAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :created_at, :date
    add_column :photos, :created_at, :datetime
  end
end
