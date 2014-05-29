class AddEventTable < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :details
      t.datetime :start_time
      t.datetime :end_time
      t.integer :message_length
      t.string :url

      t.belongs_to :user
    end
  end
end
