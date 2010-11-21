require 'services/parse.rb'

class HomeController < ApplicationController
  def index
  end

  def retrieve_posts
    parser = Parse.new(params[:feed], params[:email], params[:password])
    parser.get_posts

    redirect_to("/authors")
  end

end
