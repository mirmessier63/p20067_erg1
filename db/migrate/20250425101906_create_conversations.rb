class CreateConversations < ActiveRecord::Migration[8.0]
  def change
    create_table :conversations do |t|
      t.string :participants
      t.integer :chat_id
      t.integer :message_id
      t.string :chat_name
      t.string :sender_email
      t.string :message

      t.timestamps
    end
  end
end
