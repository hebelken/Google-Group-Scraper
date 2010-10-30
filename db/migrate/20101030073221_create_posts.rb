class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.integer :author_id
      t.decimal :rating
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
