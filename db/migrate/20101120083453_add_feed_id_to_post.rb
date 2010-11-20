class AddFeedIdToPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :feed_id, :integer
  end

  def self.down
    remove_column :posts, :feed_id
  end
end
