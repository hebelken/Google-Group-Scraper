require 'test_helper'

class AuthorTest < ActiveSupport::TestCase
  test "should know its average rating" do  
    author = Author.create(:name => 'Ken')
    post = Post.create(:rating => 5, :author => author)  
    assert_not_nil author.average_rating
    assert_equal(5, author.average_rating)
  end
end
