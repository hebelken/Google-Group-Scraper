require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup() 
      @author = Author.new(:name => "hebelken")
  end

  test "should have author" do 
    post = Post.new(:author => @author)
    assert_equal("hebelken", post.author.name)
  end	

end
