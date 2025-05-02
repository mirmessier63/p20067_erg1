class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :topic_id
      t.string :post_text
      t.integer :comment_id
      t.text :user_email
      t.string :text
      t.integer :thread_id
      t.integer :category_id

      t.timestamps
    end
    add_index :posts, :id, unique: true
  end
end
