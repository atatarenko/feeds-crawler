require 'parallel'
require 'pry'
require 'crawlers/rss'
require 'crawlers/facebook'

class FeedsCrawler
  def self.crawl(*rss_urls)
    urls = Array(rss_urls)
    crawl_feeds_articles(urls).flatten
  end

  def self.crawl_feeds_articles(rss_urls)
    rss_urls.map do |url|
      if facebook?(url)
        Crawlers::Facebook.new(url).articles
      else
        Crawlers::Rss.new(url).articles
      end
    end
  end
  private_class_method :crawl_feeds_articles

  def self.facebook?(url)
    url.match(/facebook/)
  end
  private_class_method :facebook?
end
