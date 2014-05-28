class AddMessagesTable < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :category
      t.string :twilio_object

      t.belongs_to :event
    end
  end
end
