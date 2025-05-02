class CreateNotifications < ActiveRecord::Migration[8.0]
  def change
    create_table :notifications do |t|
      t.string :to_user
      t.string :message

      t.timestamps
    end
  end
end
