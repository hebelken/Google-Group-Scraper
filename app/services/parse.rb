
#coding: utf-8
require 'rubygems'
require 'mechanize'
require 'nokogiri'
require 'open-uri'
require 'uri'


class Parse 
  

  def initialize (feed_url, username, password)
    @feed_url = feed_url
    @username = username
    @password = password
    @agent = Mechanize.new
    @agent.follow_meta_refresh = true
    @feed_id = 0
  end

  def valid_url
    @agent.get("https://www.google.com/accounts/ServiceLogin?passive=true&hl=en&service=groups2&continue=#{@feed_url}") rescue false
  end


  def auth()
    form = @agent.page.forms.first
    form.Email = @username
    form.Passwd = @password
    file = form.submit
    result = file.filename.match(/.*.xml/).nil?
    file.save("feed.xml")
    return result
  end
    

  def get_posts() 
    doc = Nokogiri::XML(open("feed.xml"))
    items = doc.xpath("//link")
    items.shift
    links = []
    items.each do |item|
      links = links.push(item.content())
    end

    links.each do |item|
      if Post.find_by_url(item).nil?
        parse_post(item)
      end
    end
  end

  def get_feed_id
    return @feed_id
  end

  private
  def parse_post(link)
    
    @agent.get(link)
    numPosts = @agent.page.search(".author span").length
    for i in (0..numPosts-1)
      post = Post.new
      post.author = Author.find_or_create_by_name(:name => @agent.page.search(".author span").map(&:text)[i])


      post.body = format_body(@agent.page.search("#inbdy").map(&:text)[i])

      post.rating = get_rating(i+1)
      post.url = link
      post.feed_id = Feed.find_or_create_by_url(@feed_url).id
      @feed_id = post.feed_id
      post.save!
    end
    
    return post   
  end
  
  def get_rating(i)
    maxRating = 4
    rating = 0
    currentAuthor = @agent.page.search("#top span").to_s().split(/<span class="fontsize2 author">.*/)[i]
    return rating if currentAuthor.scan(/(clear_bg_yellow_star_on.gif|clear_bg_star_off.gif)/)[0].nil?
    for starNum in (0..maxRating)
      currentStar = currentAuthor.scan(/(clear_bg_yellow_star_on.gif|clear_bg_star_off.gif)/)[starNum][0]
      rating = rating +1 if currentStar.eql?("clear_bg_yellow_star_on.gif")
    end
    return rating    
  end

  def format_body(text)
    result = ""
    result = text.split(/>>>.*>>>.*/)[0]
    result = result.split(/- Hide quoted text -- Show quoted text -.*/)[0]
    result = result.split(/On \b(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sept|Oct|Nov|Dec) [0-9]?[0-9], [0-9]?[0-9]:[0-9][0-9].*/)[0]
    result = result.split(/On [0-9]?[0-9]\/[0-9]?[0-9]\/[0-9]?[0-9] [0-9]?[0-9]:[0-9][0-9] (AM|PM|am|pm),.*/)[0]
    result = result.split(/On \b(Mon|Tue|Wed|Thu|Fri|Sat|Sun), [0-9]?[0-9]\/[0-9]?[0-9]\/[0-9]?[0-9],.*/)[0]
    result = result.split(/On \b(Mon|Tue|Wed|Thu|Fri|Sat|Sun)?,? ?\b(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sept|Oct|Nov|Dec) [0-3]?[0-9], [0-9]?[0-9]?[0-9]?[0-9]? \b(at)? ?[0-9]?[0-9]:[0-9][0-9].*/)[0]
    return result
  end


end
    
