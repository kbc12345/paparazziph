class Initial < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name
      t.string :cover_photo
    end

    create_table :photos do |t|
      t.string :url
      t.integer :album_id
    end
  end
end
