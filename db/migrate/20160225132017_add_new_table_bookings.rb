class AddNewTableBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string :category
      t.string :rate
      t.string :client_name
      t.string :client_email
      t.string :client_number
      t.string :event_title
      t.string :date
      t.string :start_time
      t.string :venue
      t.text :comment
    end
  end
end
