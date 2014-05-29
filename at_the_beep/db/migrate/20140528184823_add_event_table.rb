class AddEventTable < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :details
      t.date :date
      t.integer :message_length
      t.integer :message_length
      t.string :url

      t.belongs_to :user
    end
  end
end
