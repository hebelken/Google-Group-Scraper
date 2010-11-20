require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'open-uri'

class Parse 
  
    agent = Mechanize.new
    agent.follow_meta_refresh = true

  def initialize (feed_url, username, password)
    @feed_url = feed_url
    @username = username
    @password = password
  end

  def get_post_links()  
    agent.get("https://www.google.com/accounts/ServiceLogin?passive=true&hl=en&service=groups2&continue=#{@feed_url}")  
    form = agent.page.forms.first
    form.Email = @username
    form.Passwd = @password
    file = form.submit

    file.save("feed.xml")
    doc = Nokogiri::XML(open("feed.xml"))
    items = doc.xpath("//link")
    items.shift
    items.each do |item|
      links = links.push(item.content())
    end
    return links
  end

  def gather_posts(links)
    links.each do |item|
      parse_post(item)
    end
  
  end

  private
  def parse_post(link)
    agent.get(link)
    post = Post.new
    post.author = agent.page.search(".author span").map(&:text).map(&:strip)
    post.body = agent.page.search("#inbdy").map(&:text).map(&:strip)
    post.rating = 0
    post.save
    
    return post   
  end
end
    

