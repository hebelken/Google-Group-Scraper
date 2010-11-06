class Author < ActiveRecord::Base

  has_many :posts
  
  def average_rating 
    posts.average('rating')
  end
  
end
