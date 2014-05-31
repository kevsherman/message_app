class AddMessagesTable < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :category
      t.string :twilio_object
      t.string :recording_url
      t.string :from_phone
      t.string :call_sid
      t.string :recording_sid


      t.belongs_to :event
    end
  end
end
