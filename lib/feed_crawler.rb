require 'parallel'
require 'rss_feed'

class FeedCrawler
  def self.crawl(*rss_urls)
    urls = Array(rss_urls)
    crawl_feeds_articles(urls).flatten
  end

  def self.crawl_feeds_articles(rss_urls)
    Parallel.map(rss_urls) { |url| RssFeed.new(url).articles }
  end
  private_class_method :crawl_feeds_articles
end
