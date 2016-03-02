class AddNewTableQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :name
      t.string :email
      t.string :mobile
      t.text :message
    end
  end
end
