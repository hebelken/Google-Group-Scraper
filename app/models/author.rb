class Author < ActiveRecord::Base

  has_many :posts
  belongs_to :feed
  
  def average_rating 
    posts.average('rating')
  end

  
end
