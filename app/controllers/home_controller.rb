require 'services/parse.rb'

class HomeController < ApplicationController
  def index
  end

  def retrieve_posts
    parser = Parse.new(params[:feed], params[:email], params[:password])
    parser.get_posts
    @feed_id = parser.get_feed_id
    redirect_to("/posts/#{@feed_id}")
  end


end
