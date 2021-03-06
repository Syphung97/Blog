class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.text :title
      t.text :content
      t.references :author, foreign_key: true

      t.timestamps
    end
    add_index :posts, [:author_id, :created_at]
  end
end
