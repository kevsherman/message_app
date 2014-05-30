class AddEventTable < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :details
      t.date :date
      t.integer :message_length
      t.integer :limit_messages
      t.string :url
      t.boolean :status, default: true

      t.belongs_to :user
    end
  end
end
