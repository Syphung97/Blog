class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.references :author, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
    end
    add_index :likes, [:author_id, :post_id], unique: true 
  end
end
