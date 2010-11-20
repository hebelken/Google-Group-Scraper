require 'services/parse.rb'

class HomeController < ApplicationController
  def index
  end

  def retrieve_posts
    parser = Parse.new(params[:Feed], params[:Email], params[:Password])


    redirect_to("/authors")
  end

end
