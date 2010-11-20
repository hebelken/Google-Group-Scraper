class Post < ActiveRecord::Base

  belongs_to :author
  belongs_to :feed

end
