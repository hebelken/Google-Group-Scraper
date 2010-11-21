
#coding: utf-8
require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'open-uri'

class Parse 
  

  def initialize (feed_url, username, password)
    @feed_url = feed_url
    @username = username
    @password = password
    @agent = Mechanize.new
    @agent.follow_meta_refresh = true
  end

  def get_posts() 
    @agent.get("https://www.google.com/accounts/ServiceLogin?passive=true&hl=en&service=groups2&continue=#{@feed_url}")  
    form = @agent.page.forms.first
    form.Email = @username
    form.Passwd = @password
    file = form.submit

    file.save("feed.xml")
    doc = Nokogiri::XML(open("feed.xml"))
    items = doc.xpath("//link")
    items.shift
    links = []
    items.each do |item|
      links = links.push(item.content())
    end

    links.each do |item|
      if Post.find_by_url(item).nil? == true
        parse_post(item)
      end
    end
  end

  private
  def parse_post(link)
    
    @agent.get(link)
    numPosts = @agent.page.search(".author span").length
    for i in (0..numPosts)
      post = Post.new
      post.author = Author.find_or_create_by_name(:name => @agent.page.search(".author span").map(&:text)[i])

      post.body = @agent.page.search("#inbdy").map(&:text)[i].split(/On \b(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sept|Oct|Nov|Dec) [0-3]?[0-9], [0-9][0-9][0-9][0-9] [0-9]?[0-9]:[0-9][0-9] AM,.*/)[0].strip
      post.rating = 0
      post.url = link
      post.feed = Feed.find_or_create_by_url(@feed_url)
      post.save!
    end
    
    return post   
  end
end
    
