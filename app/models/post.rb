class Post < ActiveRecord::Base

  belongs_to :author
  belongs_to :feed

  named_scope :by_feed_id, lambda { |feed_id|{:conditions => ["feed_id = ?", feed_id]} }


end
