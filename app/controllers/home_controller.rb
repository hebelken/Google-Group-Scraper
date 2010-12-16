require 'services/parse.rb'

class HomeController < ApplicationController
  def index
  end

  def retrieve_posts
    parser = Parse.new(params[:feed], params[:email], params[:password])
    if !parser.valid_url
      flash[:error] = "Invalid Feed Path" 
      redirect_to root_path
      return
    end
    if !parser.auth 
      parser.get_posts
      @feed_id = parser.get_feed_id
      redirect_to("/posts/#{@feed_id}")
    else
      flash[:error] = "Incorrect Login or Password" 
      redirect_to root_path
    end   
  end


end
