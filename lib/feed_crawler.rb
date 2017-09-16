require 'rss_feed'

class FeedCrawler
  def self.crawl(*urls)
    Array(urls)
      .map(&method(:crawl_articles))
      .flatten
  end

  def self.crawl_articles(rss_url)
    RssFeed.new(rss_url).articles
  end
  private_class_method :crawl_articles
end
