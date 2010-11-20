class AddFeedIdToAuthor < ActiveRecord::Migration
  def self.up
    add_column :authors, :feed_id, :integer
  end

  def self.down
    remove_column :authors, :feed_id
  end
end
