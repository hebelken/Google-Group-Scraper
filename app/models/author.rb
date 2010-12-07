class Author < ActiveRecord::Base

  has_many :posts
  belongs_to :feed
  
  def average_rating 
    posts.average('rating')
  end

  named_scope :by_feed_id, lambda { |feed_id|{:conditions => ["feed_id = ?", feed_id]} }

  
end
