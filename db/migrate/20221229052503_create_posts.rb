class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :slug
      t.integer :post_identifier
      t.string :title
      t.datetime :published_at
      t.boolean :published
      t.integer :user_id
      t.string :image_description
      t.text :body

      t.timestamps
    end
    add_index :posts, :post_identifier, unique: true
  end
end
