class CreateNewTableReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.string :reviewer
      t.text :message
    end
  end
end
